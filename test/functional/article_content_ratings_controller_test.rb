require 'test_helper'

class ArticleContentRatingsControllerTest < ActionController::TestCase
  setup do
    @article_content_rating = article_content_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:article_content_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article_content_rating" do
    assert_difference('ArticleContentRating.count') do
      post :create, :article_content_rating => {  }
    end

    assert_redirected_to article_content_rating_path(assigns(:article_content_rating))
  end

  test "should show article_content_rating" do
    get :show, :id => @article_content_rating
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @article_content_rating
    assert_response :success
  end

  test "should update article_content_rating" do
    put :update, :id => @article_content_rating, :article_content_rating => {  }
    assert_redirected_to article_content_rating_path(assigns(:article_content_rating))
  end

  test "should destroy article_content_rating" do
    assert_difference('ArticleContentRating.count', -1) do
      delete :destroy, :id => @article_content_rating
    end

    assert_redirected_to article_content_ratings_path
  end
end
