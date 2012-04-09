require 'test_helper'

class ProxiesControllerTest < ActionController::TestCase
  test "should get twitter_user_timeline" do
    get :twitter_user_timeline
    assert_response :success
  end

end
