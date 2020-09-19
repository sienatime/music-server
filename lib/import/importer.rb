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
          TagLib::FileRef.open(full_path) do |fileref|
            if fileref.null?
              @not_processed << full_path
            elsif
              create_song(fileref.tag, fileref.audio_properties.length_in_seconds, relative_path)
            end
          end
        end
      end
    end

    def create_song(tag, length_in_seconds, path)
      song = Song.new

      artist = Artist.find_or_create_by(name: tag.artist)
      song.artist = artist

      unless tag.album.blank?
        song.album = Album.find_or_create_by(title: tag.album, artist_id: artist.id)
      end

      song.title = tag.title
      song.year = tag.year
      song.track_number = tag.track if tag.track > 0
      song.genre = tag.genre
      song.length = length_in_seconds
      song.path = path

      if song.valid?
        song.save!
      else
        song_import_error = SongImportError.new(song.errors.full_messages.join(", "), song.path)
        @errors << song_import_error
      end
    end
  end
end
