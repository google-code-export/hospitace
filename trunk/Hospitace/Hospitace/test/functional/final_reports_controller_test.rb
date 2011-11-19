require 'test_helper'

class FinalReportsControllerTest < ActionController::TestCase
  setup do
    @final_report = final_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:final_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create final_report" do
    assert_difference('FinalReport.count') do
      post :create, final_report: @final_report.attributes
    end

    assert_redirected_to final_report_path(assigns(:final_report))
  end

  test "should show final_report" do
    get :show, id: @final_report.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @final_report.to_param
    assert_response :success
  end

  test "should update final_report" do
    put :update, id: @final_report.to_param, final_report: @final_report.attributes
    assert_redirected_to final_report_path(assigns(:final_report))
  end

  test "should destroy final_report" do
    assert_difference('FinalReport.count', -1) do
      delete :destroy, id: @final_report.to_param
    end

    assert_redirected_to final_reports_path
  end
end
