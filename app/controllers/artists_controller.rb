class ArtistsController < ApplicationController
  def index
    @artists = Artist.order(name: :asc).limit(Rails.configuration.per_page)
  end

  def show
    @artist = Artist.find(params[:id])
  end
end
