require 'test_helper'

class TitlesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should search for title" do
    get(:search, { 'term' => 'Star Trek' })
    assert_response :success
  end

end
