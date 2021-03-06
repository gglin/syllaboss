require 'test_helper'

class SchoolDaysControllerTest < ActionController::TestCase
  setup do
    @school_day = school_days(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:school_days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create school_day" do
    assert_difference('SchoolDay.count') do
      post :create, school_day: { calendar_date: @school_day.calendar_date, ordinal: @school_day.ordinal, schedule: @school_day.schedule, week: @school_day.week }
    end

    assert_redirected_to school_day_path(assigns(:school_day))
  end

  test "should show school_day" do
    get :show, id: @school_day
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @school_day
    assert_response :success
  end

  test "should update school_day" do
    put :update, id: @school_day, school_day: { calendar_date: @school_day.calendar_date, ordinal: @school_day.ordinal, schedule: @school_day.schedule, week: @school_day.week }
    assert_redirected_to school_day_path(assigns(:school_day))
  end

  test "should destroy school_day" do
    assert_difference('SchoolDay.count', -1) do
      delete :destroy, id: @school_day
    end

    assert_redirected_to school_days_path
  end
end
