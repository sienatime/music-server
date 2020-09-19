class AlbumsController < ApplicationController
  def index
    @albums = Album.order(title: :asc).limit(30)
  end

  def show
    @album = Album.find(params[:id])
  end
end
