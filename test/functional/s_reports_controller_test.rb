require 'test_helper'

class SReportsControllerTest < ActionController::TestCase
  setup do
    @s_report = s_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:s_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create s_report" do
    assert_difference('SReport.count') do
      post :create, s_report: { description: @s_report.description, job_id: @s_report.job_id }
    end

    assert_redirected_to s_report_path(assigns(:s_report))
  end

  test "should show s_report" do
    get :show, id: @s_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @s_report
    assert_response :success
  end

  test "should update s_report" do
    put :update, id: @s_report, s_report: { description: @s_report.description, job_id: @s_report.job_id }
    assert_redirected_to s_report_path(assigns(:s_report))
  end

  test "should destroy s_report" do
    assert_difference('SReport.count', -1) do
      delete :destroy, id: @s_report
    end

    assert_redirected_to s_reports_path
  end
end
