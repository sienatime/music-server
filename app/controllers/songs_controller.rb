class SongsController < ApplicationController
  def download
    song_ids = params[:ids]

    if song_ids.size == 1
      song = Song.find(song_ids.first)
      send_file "#{Rails.root}/#{song.path}"
    end
  end
end
