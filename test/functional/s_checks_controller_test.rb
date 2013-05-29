require 'test_helper'

class SChecksControllerTest < ActionController::TestCase
  setup do
    @s_check = s_checks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:s_checks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create s_check" do
    assert_difference('SCheck.count') do
      post :create, s_check: { description: @s_check.description, job_id: @s_check.job_id }
    end

    assert_redirected_to s_check_path(assigns(:s_check))
  end

  test "should show s_check" do
    get :show, id: @s_check
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @s_check
    assert_response :success
  end

  test "should update s_check" do
    put :update, id: @s_check, s_check: { description: @s_check.description, job_id: @s_check.job_id }
    assert_redirected_to s_check_path(assigns(:s_check))
  end

  test "should destroy s_check" do
    assert_difference('SCheck.count', -1) do
      delete :destroy, id: @s_check
    end

    assert_redirected_to s_checks_path
  end
end
