require 'test_helper'

class EventMapsControllerTest < ActionController::TestCase
  setup do
    @event_map = event_maps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_maps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_map" do
    assert_difference('EventMap.count') do
      post :create, event_map: { chinese_description: @event_map.chinese_description, chinese_thread_id: @event_map.chinese_thread_id, description: @event_map.description, suggestion: @event_map.suggestion, thread_id: @event_map.thread_id }
    end

    assert_redirected_to event_map_path(assigns(:event_map))
  end

  test "should show event_map" do
    get :show, id: @event_map
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_map
    assert_response :success
  end

  test "should update event_map" do
    put :update, id: @event_map, event_map: { chinese_description: @event_map.chinese_description, chinese_thread_id: @event_map.chinese_thread_id, description: @event_map.description, suggestion: @event_map.suggestion, thread_id: @event_map.thread_id }
    assert_redirected_to event_map_path(assigns(:event_map))
  end

  test "should destroy event_map" do
    assert_difference('EventMap.count', -1) do
      delete :destroy, id: @event_map
    end

    assert_redirected_to event_maps_path
  end
end
