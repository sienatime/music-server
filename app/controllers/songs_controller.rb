require 'zip'

class SongsController < ApplicationController
  def index
    @songs = Song.order(title: :asc).limit(Rails.configuration.per_page)
  end

  def download
    songs = Song.find(params[:ids])

    if song_ids.size == 1
      send_file "#{Rails.root}/#{songs.first.path}"
    else
      zip_file_location = "tmp/download.zip"
      create_zip(zip_file_location)
      send_file zip_file_location
    end
  end

  private

  def create_zip(zip_file_location)
    File.delete(zip_file_location) if File.exist?(zip_file_location)

    Zip::File.open(zip_file_location, Zip::File::CREATE) do |zipfile|
      songs.each do |song|
        zipfile.add(
          song.filename,
          File.join("#{Rails.root}/#{song.folder}", song.filename)
        )
      end
    end
  end
end
