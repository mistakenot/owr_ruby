require 'rest_client'
require 'json'

module TitlesHelper

  def download_description(title)
    result = RestClient.get(
      "http://www.omdbapi.com/",
      { :params => {
        "i" => title.imdbId,
        "plot" => "short",
        "r" => "json" }
      }
    )

    if result["Response"].to_b
      title.description = result["Plot"]
      title.save
    else
      raise result["Error"]
    end
  end

end
