class HomeController < ApplicationController
  def index
    if Artist.count == 0
      render 'home/import'
    else
      redirect_to artists_index_path
    end
  end

  def import
    Importer.start("")
  end
end
