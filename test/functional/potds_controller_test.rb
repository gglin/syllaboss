require 'test_helper'

class PotdsControllerTest < ActionController::TestCase
  setup do
    @potd = potds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:potds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create potd" do
    assert_difference('Potd.count') do
      post :create, potd: {  }
    end

    assert_redirected_to potd_path(assigns(:potd))
  end

  test "should show potd" do
    get :show, id: @potd
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @potd
    assert_response :success
  end

  test "should update potd" do
    put :update, id: @potd, potd: {  }
    assert_redirected_to potd_path(assigns(:potd))
  end

  test "should destroy potd" do
    assert_difference('Potd.count', -1) do
      delete :destroy, id: @potd
    end

    assert_redirected_to potds_path
  end
end
