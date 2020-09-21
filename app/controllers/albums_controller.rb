class AlbumsController < ApplicationController
  def index
    @albums = Album.order(title: :asc).limit(Rails.configuration.per_page)
  end

  def show
    @album = Album.find(params[:id])
  end
end
