class HomeController < ApplicationController
  def index
    # if Artist.count == 0
      render 'home/import'
    # else
    #   redirect_to artists_path
    # end
  end

  def import
    result = Import::Importer.new(params["directory"]).start()
    # render partial: "import_result", locals: { result: result }

    respond_to do |format|
      format.js { render :json => result }
    end
  end
end
