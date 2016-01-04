require 'test_helper'

class ActivitesControllerTest < ActionController::TestCase
  test "should get all-events" do
    get :all-events
    assert_response :success
  end

end
