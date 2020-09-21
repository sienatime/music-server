require 'taglib'

module Import
  class Importer
    def initialize(directory)
      @directory = directory
      @errors = []
      @not_processed = []
      @totals = {}
    end

    def start()
      Importer.destroy_all

      absolute_path = "#{Rails.root}/#{@directory}"

      recurse(absolute_path, @directory)

      # todo: move this to background job
      Search::Indexer.index

      @totals[:albums] = Album.count
      @totals[:artists] = Artist.count
      @totals[:songs] = Song.count

      ImportResult.new(@errors, @not_processed, @totals)
    end

    def self.destroy_all
      Song.destroy_all
      Artist.destroy_all
      Album.destroy_all
    end

    private

    def recurse(absolute_path, original_path)
      Dir.foreach(absolute_path) do |filename|
        next if filename == '.' or filename == '..'

        full_path = "#{absolute_path}/#{filename}"
        relative_path = "#{original_path}/#{filename}"

        if File.directory?(full_path)
          recurse(full_path, relative_path)
        else
          TagLib::MPEG::File.open(full_path) do |file|
            if file.nil? || file.id3v2_tag.nil?
              @not_processed << full_path
            elsif
              create_song(file.id3v2_tag, file.audio_properties.length_in_seconds, original_path, filename)
            end
          end
        end
      end
    end

    def album_artist(tag)
      tag.frame_list("TPE2").first.to_s
    end

    def disc_number(tag)
      # returns a string like 3/4, or nil
      if (disc_info = tag.frame_list("TPOS").first.to_s)
        disc_info.split("/").first
      end
    end

    def create_album(tag, song_artist)
      return if tag.album.blank?

      if (album_artist_name = album_artist(tag)).present?
        album_artist = Artist.find_or_create_by(name: album_artist_name)
        Album.find_or_create_by(title: tag.album, artist_id: album_artist.id)
      else
        Album.find_or_create_by(title: tag.album, artist_id: song_artist.id)
      end
    end

    def create_song(tag, length_in_seconds, folder, filename)
      song = Song.new

      song_artist = Artist.find_or_create_by(name: tag.artist)
      song.artist = song_artist

      song.album = create_album(tag, song_artist)

      song.title = tag.title
      song.year = tag.year
      song.track_number = tag.track if tag.track > 0
      song.genre = tag.genre
      song.disc_number = disc_number(tag)
      song.length = length_in_seconds
      song.folder = folder
      song.filename = filename

      if song.valid?
        song.save!
      else
        song_import_error = SongImportError.new(
          song.errors.full_messages.join(", "),
          song.path
        )
        @errors << song_import_error
      end
    end
  end
end
