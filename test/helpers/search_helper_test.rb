require 'test_helper'

class SearchHelperTest < ActionController::TestCase

  test "download known movie summary using term" do
    term = "Lion King"
    results = SearchHelper.searchByTerm(term)
    first = results[0]

    assert_equal "The Lion King", first["Title"]
    assert_not_equal "N/A", first["Poster"]
    assert results.all? { |r| r["Poster"] != "N/A" }
  end

end
