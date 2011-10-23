require 'test_helper'

class PeoplesControllerTest < ActionController::TestCase
  test "should get peoples" do
    get :peoples
    assert_response :success
  end

end
