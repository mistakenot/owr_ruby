require 'rest_client'
require 'json'

module TitlesHelper

  def self.download_description(title)
    resultString = RestClient.get(
      "http://www.omdbapi.com/",
      { :params => {
        "i" => title.imdbId,
        "plot" => "short",
        "r" => "json" }
      }
    )

    result = JSON.parse resultString.to_s

    if result["Response"].to_s == "True"
      title.description = result["Plot"]
      title.save
    else
      result["Error"].to_s
    end
  end

  def self.search_json_to_title(j)
    Title.new(
      :title => j["Title"],
      :imdbId => j["imdbID"],
      :year => j["Year"].to_i,
      :description => nil
    )
  end

  def self.import_title(t)
    Title.find_by(imdbId: t.imdbId) || t.save
  end

  def by_imdbId(imdbId)
    Title.find_by imdbId: imdbId
  end

end
