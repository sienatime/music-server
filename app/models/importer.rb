require 'taglib'

class Importer
  class << self
    def start(directory)
      destroy_all

      TagLib::FileRef.open("#{Rails.root}/#{directory}/Squad Goals - Future Funk DJ Mix.mp3") do |fileref|
        if fileref.null?
          puts "file is null!"
        elsif
          create_song(fileref.tag, fileref.audio_properties.length_in_seconds)
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

      song.save!
    end

    def destroy_all
      Song.destroy_all
      Artist.destroy_all
      Album.destroy_all
    end
  end
end
