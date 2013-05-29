require 'test_helper'

class IpMapsControllerTest < ActionController::TestCase
  setup do
    @ip_map = ip_maps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ip_maps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ip_map" do
    assert_difference('IpMap.count') do
      post :create, ip_map: { adm: @ip_map.adm, department: @ip_map.department, ip: @ip_map.ip, user: @ip_map.user }
    end

    assert_redirected_to ip_map_path(assigns(:ip_map))
  end

  test "should show ip_map" do
    get :show, id: @ip_map
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ip_map
    assert_response :success
  end

  test "should update ip_map" do
    put :update, id: @ip_map, ip_map: { adm: @ip_map.adm, department: @ip_map.department, ip: @ip_map.ip, user: @ip_map.user }
    assert_redirected_to ip_map_path(assigns(:ip_map))
  end

  test "should destroy ip_map" do
    assert_difference('IpMap.count', -1) do
      delete :destroy, id: @ip_map
    end

    assert_redirected_to ip_maps_path
  end
end
