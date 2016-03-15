require 'rest_client'
require 'json'

module SearchHelper

  def self.searchByTerm(term)
    result = RestClient.get(
      "http://www.omdbapi.com/",
      { params: {
        "s" => term,
        "type" => "movie",
        "page" => "1" }
      }
    )
    json = JSON.parse result.to_str
    json["Search"].select { |j| j["Poster"] != "N/A" }
  end
  
end
