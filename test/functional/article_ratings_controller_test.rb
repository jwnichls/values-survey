require 'test_helper'

class ArticleRatingsControllerTest < ActionController::TestCase
  setup do
    @article_rating = article_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:article_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article_rating" do
    assert_difference('ArticleRating.count') do
      post :create, :article_rating => {  }
    end

    assert_redirected_to article_rating_path(assigns(:article_rating))
  end

  test "should show article_rating" do
    get :show, :id => @article_rating
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @article_rating
    assert_response :success
  end

  test "should update article_rating" do
    put :update, :id => @article_rating, :article_rating => {  }
    assert_redirected_to article_rating_path(assigns(:article_rating))
  end

  test "should destroy article_rating" do
    assert_difference('ArticleRating.count', -1) do
      delete :destroy, :id => @article_rating
    end

    assert_redirected_to article_ratings_path
  end
end
