require 'test_helper'

class AdmUsersControllerTest < ActionController::TestCase
  setup do
    @adm_user = adm_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adm_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adm_user" do
    assert_difference('AdmUser.count') do
      post :create, adm_user: { authorization: @adm_user.authorization, email: @adm_user.email, extend: @adm_user.extend, name: @adm_user.name, phone: @adm_user.phone, pw: @adm_user.pw, username: @adm_user.username }
    end

    assert_redirected_to adm_user_path(assigns(:adm_user))
  end

  test "should show adm_user" do
    get :show, id: @adm_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @adm_user
    assert_response :success
  end

  test "should update adm_user" do
    put :update, id: @adm_user, adm_user: { authorization: @adm_user.authorization, email: @adm_user.email, extend: @adm_user.extend, name: @adm_user.name, phone: @adm_user.phone, pw: @adm_user.pw, username: @adm_user.username }
    assert_redirected_to adm_user_path(assigns(:adm_user))
  end

  test "should destroy adm_user" do
    assert_difference('AdmUser.count', -1) do
      delete :destroy, id: @adm_user
    end

    assert_redirected_to adm_users_path
  end
end
