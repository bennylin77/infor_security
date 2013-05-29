require 'test_helper'

class JobDetailsControllerTest < ActionController::TestCase
  setup do
    @job_detail = job_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:job_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job_detail" do
    assert_difference('JobDetail.count') do
      post :create, job_detail: { action: @job_detail.action, description: @job_detail.description, job_id: @job_detail.job_id, log_count: @job_detail.log_count, log_date: @job_detail.log_date, region: @job_detail.region, serverity: @job_detail.serverity, src_ip: @job_detail.src_ip, threat_id: @job_detail.threat_id }
    end

    assert_redirected_to job_detail_path(assigns(:job_detail))
  end

  test "should show job_detail" do
    get :show, id: @job_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @job_detail
    assert_response :success
  end

  test "should update job_detail" do
    put :update, id: @job_detail, job_detail: { action: @job_detail.action, description: @job_detail.description, job_id: @job_detail.job_id, log_count: @job_detail.log_count, log_date: @job_detail.log_date, region: @job_detail.region, serverity: @job_detail.serverity, src_ip: @job_detail.src_ip, threat_id: @job_detail.threat_id }
    assert_redirected_to job_detail_path(assigns(:job_detail))
  end

  test "should destroy job_detail" do
    assert_difference('JobDetail.count', -1) do
      delete :destroy, id: @job_detail
    end

    assert_redirected_to job_details_path
  end
end
