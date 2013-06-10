class ArticleContentRatingsController < ApplicationController
  before_filter :get_participant
  protect_from_forgery :except => [:new, :create, :index]
  
  # GET /article_content_ratings
  # GET /article_content_ratings.json
  def index
    @article_content_ratings = ArticleContentRating.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @article_content_ratings }
    end
  end


  # GET /article_content_ratings/new
  # GET /article_content_ratings/new.json
  def new
    @article_content_rating = ArticleContentRating.new
    @article_rating = ArticleRating.find(params[:article_rating_id])
    @article = Article.find(@article_rating.article_id)
    @article_content_rating.article_id = @article.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @article_content_rating }
    end
  end

  # POST /article_content_ratings
  # POST /article_content_ratings.json
  def create
    @article_content_rating = ArticleContentRating.new(params[:article_content_rating])
    @article_content_rating.participant_id = @participant.id

    @article_content_ratings_old = ArticleContentRating.find(:all, :conditions => [ "participant_id = ?", @participant.id], :group => 'article_id')

    if @article_content_ratings_old != nil and @article_content_ratings_old.size >= 2
          respond_to do |format|
            if @article_content_rating.save
              format.html { redirect_to new_participant_demographic_path(@participant) }
      #        format.html { redirect_to new_participant_demographic_path(@participant) }
              format.json { render :json => @article_content_rating, :status => :created, :location => @article_content_rating }
            else
              format.html { render :action => "new" }
              format.json { render :json => @article_content_rating.errors, :status => :unprocessable_entity }
            end
          end      
    else
        respond_to do |format|
          if @article_content_rating.save
            format.html { redirect_to new_participant_article_rating_path(@participant) }
    #        format.html { redirect_to new_participant_demographic_path(@participant) }
            format.json { render :json => @article_content_rating, :status => :created, :location => @article_content_rating }
          else
            @article = Article.find(@article_content_rating.article_id)     
            format.html { render :action => "new" }
            format.json { render :json => @article_content_rating.errors, :status => :unprocessable_entity }
          end
        end
    end
    
  end

  # PUT /article_content_ratings/1
  # PUT /article_content_ratings/1.json
  def update
    @article_content_rating = ArticleContentRating.find(params[:id])

    respond_to do |format|
      if @article_content_rating.update_attributes(params[:article_content_rating])
        format.html { redirect_to @article_content_rating, :notice => 'Article content rating was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @article_content_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  
  private
                    
    def get_participant
      @participant = Participant.find(:first, :conditions => [ "id = ?", params[:participant_id]])
      @article_rating = ArticleRating.find(:first, :conditions => [ "id = ?", params[:article_rating_id]])

    end
end
