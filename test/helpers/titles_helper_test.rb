require "test_helper"
require "json"

class TitlesHelperTest < ActionController::TestCase

  test "convert search result json to title" do
    jsonString = "{\"Title\":\"The Lion King\",\"Year\":\"1994\",\"imdbID\":\"tt0110357\",\"Type\":\"movie\",\"Poster\":\"http://ia.media-imdb.com/images/M/MV5BMjEyMzgwNTUzMl5BMl5BanBnXkFtZTcwNTMxMzM3Ng@@._V1_SX300.jpg\"}"
    json = JSON.parse jsonString
    result = TitlesHelper.search_json_to_title(json)

    assert_equal "The Lion King", result.title
    assert_equal 1994, result.year
    assert_equal "tt0110357", result.imdbId
  end

  test "download description for a title" do
    title = Title.create(
      title: "Star Trek",
      imdbId: "tt0796366",
      year: 2007
    )

    TitlesHelper.download_description(title)

    assert_equal "The brash James T. Kirk tries to live up to his father's legacy with Mr. Spock keeping him in check as a vengeful, time-traveling Romulan creates black holes to destroy the Federation one planet at a time.", title.description
  end

  test "import titles" do
    json = SearchHelper.searchByTerm("The Lion King").take(1)
    titles = json.map { |t| TitlesHelper.search_json_to_title(t) }
    TitlesHelper.import_titles(titles)
    title = titles.first
    imported = Title.find(title.id)

    assert_equal title.title, imported.title
    assert_equal title.imdbId, imported.imdbId
  end

end
