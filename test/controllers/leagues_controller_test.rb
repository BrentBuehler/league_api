require 'test_helper'

class LeaguesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get leagues_index_url
    assert_response :success
  end

  test "should get create" do
    get leagues_create_url
    assert_response :success
  end

end
