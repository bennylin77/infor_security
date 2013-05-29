require 'test_helper'

class SClosedsControllerTest < ActionController::TestCase
  setup do
    @s_closed = s_closeds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:s_closeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create s_closed" do
    assert_difference('SClosed.count') do
      post :create, s_closed: { description: @s_closed.description, job_id: @s_closed.job_id }
    end

    assert_redirected_to s_closed_path(assigns(:s_closed))
  end

  test "should show s_closed" do
    get :show, id: @s_closed
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @s_closed
    assert_response :success
  end

  test "should update s_closed" do
    put :update, id: @s_closed, s_closed: { description: @s_closed.description, job_id: @s_closed.job_id }
    assert_redirected_to s_closed_path(assigns(:s_closed))
  end

  test "should destroy s_closed" do
    assert_difference('SClosed.count', -1) do
      delete :destroy, id: @s_closed
    end

    assert_redirected_to s_closeds_path
  end
end
