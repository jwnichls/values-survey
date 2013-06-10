require 'test_helper'

class TwitterChecksControllerTest < ActionController::TestCase
  setup do
    @twitter_check = twitter_checks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:twitter_checks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create twitter_check" do
    assert_difference('TwitterCheck.count') do
      post :create, :twitter_check => {  }
    end

    assert_redirected_to twitter_check_path(assigns(:twitter_check))
  end

  test "should show twitter_check" do
    get :show, :id => @twitter_check
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @twitter_check
    assert_response :success
  end

  test "should update twitter_check" do
    put :update, :id => @twitter_check, :twitter_check => {  }
    assert_redirected_to twitter_check_path(assigns(:twitter_check))
  end

  test "should destroy twitter_check" do
    assert_difference('TwitterCheck.count', -1) do
      delete :destroy, :id => @twitter_check
    end

    assert_redirected_to twitter_checks_path
  end
end
