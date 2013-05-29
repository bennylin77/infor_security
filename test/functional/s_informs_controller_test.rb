require 'test_helper'

class SInformsControllerTest < ActionController::TestCase
  setup do
    @s_inform = s_informs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:s_informs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create s_inform" do
    assert_difference('SInform.count') do
      post :create, s_inform: { description: @s_inform.description, job_id: @s_inform.job_id }
    end

    assert_redirected_to s_inform_path(assigns(:s_inform))
  end

  test "should show s_inform" do
    get :show, id: @s_inform
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @s_inform
    assert_response :success
  end

  test "should update s_inform" do
    put :update, id: @s_inform, s_inform: { description: @s_inform.description, job_id: @s_inform.job_id }
    assert_redirected_to s_inform_path(assigns(:s_inform))
  end

  test "should destroy s_inform" do
    assert_difference('SInform.count', -1) do
      delete :destroy, id: @s_inform
    end

    assert_redirected_to s_informs_path
  end
end
