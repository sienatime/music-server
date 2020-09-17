class HomeController < ApplicationController
  def index
    if Artist.count == 0
      redirect_to import_path
    else
      redirect_to artists_index_path
    end
  end

  def import
  end
end
