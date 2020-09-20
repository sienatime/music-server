class SearchController < ApplicationController
  def query
    @results = Search::Query.go(params[:query]).map do |result|
      id = result["id"]
      type = result["TableName"]

      case type
      when "artists"
        Artist.find(id)
      when "albums"
        Album.find(id)
      when "songs"
        Song.find(id)
      end
    end
  end
end
