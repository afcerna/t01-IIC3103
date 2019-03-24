require 'test_helper'

class StarshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get starships_show_url
    assert_response :success
  end

  test "should get index" do
    get starships_index_url
    assert_response :success
  end

end
