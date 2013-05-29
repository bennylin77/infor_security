require 'test_helper'

class SHandlesControllerTest < ActionController::TestCase
  setup do
    @s_handle = s_handles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:s_handles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create s_handle" do
    assert_difference('SHandle.count') do
      post :create, s_handle: { description: @s_handle.description, job_id: @s_handle.job_id }
    end

    assert_redirected_to s_handle_path(assigns(:s_handle))
  end

  test "should show s_handle" do
    get :show, id: @s_handle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @s_handle
    assert_response :success
  end

  test "should update s_handle" do
    put :update, id: @s_handle, s_handle: { description: @s_handle.description, job_id: @s_handle.job_id }
    assert_redirected_to s_handle_path(assigns(:s_handle))
  end

  test "should destroy s_handle" do
    assert_difference('SHandle.count', -1) do
      delete :destroy, id: @s_handle
    end

    assert_redirected_to s_handles_path
  end
end
