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

      recurse(absolute_path)

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

    def recurse(absolute_path)
      Dir.foreach(absolute_path) do |filename|
        next if filename == '.' or filename == '..'

        full_path = "#{absolute_path}/#{filename}"
        puts "working with #{full_path}"

        if File.directory?(full_path)
          recurse(full_path)
        else
          TagLib::FileRef.open(full_path) do |fileref|
            if fileref.null?
              @not_processed << full_path
            elsif
              create_song(fileref.tag, fileref.audio_properties.length_in_seconds)
            end
          end
        end
      end
    end

    def create_song(tag, length_in_seconds)
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

      if song.valid?
        song.save!
      else
        @errors << song
      end
    end
  end
end

