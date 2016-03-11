require 'rest_client'
require 'json'

class TitlesController < ApplicationController

  def index
    @titles = Title.take(10)
  end

  def show
    @title = Title.find(params[:id])
  end

  def new
    @title = Title.new
  end

  def create
    @title = Title.new(title_params)
    @title.save
    redirect_to 'index'
  end

  def search
    term = params[:term]
    result = RestClient.get(
      "http://www.omdbapi.com/",
      { :params => {
        "s" => params[:term],
        "type" => "movie",
        "page" => "1" }
      }
    )

    if result.code == 200
      json = JSON.parse result.to_str
      @results = json["Search"].map { |j|
        movie = Title.find_by imdbId: j["imdbID"]
        if movie == nil
          movie = Title.create(
            :title => j["Title"],
            :imdbId => j["imdbID"],
            :year => j["Year"].to_i
          )
        end
        movie
      }
    else
      render plain: result.code
    end
  end

  private
    def title_params
      params.require(:title).permit(:description, :imdbId)
    end
end
