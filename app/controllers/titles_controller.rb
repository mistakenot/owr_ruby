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
    json = SearchHelper.searchByTerm(term)
    @results = json.map { |j|
      find = Title.find_by(imdbId: j["imdbID"])
      if find
        find
      else
        newTitle = TitlesHelper.search_json_to_title(j)
        newTitle.save!
        newTitle
      end
    }
  end

  private
    def title_params
      params.require(:title).permit(:description, :imdbId)
    end
end
