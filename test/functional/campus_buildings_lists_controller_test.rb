require 'test_helper'

class CampusBuildingsListsControllerTest < ActionController::TestCase
  setup do
    @campus_buildings_list = campus_buildings_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:campus_buildings_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create campus_buildings_list" do
    assert_difference('CampusBuildingsList.count') do
      post :create, campus_buildings_list: { building_name: @campus_buildings_list.building_name, campus_name: @campus_buildings_list.campus_name }
    end

    assert_redirected_to campus_buildings_list_path(assigns(:campus_buildings_list))
  end

  test "should show campus_buildings_list" do
    get :show, id: @campus_buildings_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @campus_buildings_list
    assert_response :success
  end

  test "should update campus_buildings_list" do
    put :update, id: @campus_buildings_list, campus_buildings_list: { building_name: @campus_buildings_list.building_name, campus_name: @campus_buildings_list.campus_name }
    assert_redirected_to campus_buildings_list_path(assigns(:campus_buildings_list))
  end

  test "should destroy campus_buildings_list" do
    assert_difference('CampusBuildingsList.count', -1) do
      delete :destroy, id: @campus_buildings_list
    end

    assert_redirected_to campus_buildings_lists_path
  end
end
