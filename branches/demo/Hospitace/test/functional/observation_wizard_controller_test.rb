require 'test_helper'

class ObservationWizardControllerTest < ActionController::TestCase
  test "should get step1" do
    get :step1
    assert_response :success
  end

  test "should get step2" do
    get :step2
    assert_response :success
  end

  test "should get step3" do
    get :step3
    assert_response :success
  end

end
