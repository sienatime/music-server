class ArtistsController < ApplicationController
  def index
    @artists = Artist.order(name: :asc).limit(30)
  end

  def show
  end
end
