class ArticleRatingsController < ApplicationController
  before_filter :get_participant
  protect_from_forgery :except => [:new, :create, :index]

  # GET /article_ratings
  # GET /article_ratings.json
  def index
    @article_ratings = ArticleRating.all

    @articleRatings_old = ArticleRating.find(:all, :conditions => [ "participant_id = ?", @participant.id], :group => 'article_id')
    
    if @articleRatings_old != nil and @articleRatings_old.size >= 3
      redirect_to new_participant_demographic_path(@participant)

    else
      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @article_ratings }
      end
    end

  end

  # GET /article_ratings/new
  # GET /article_ratings/new.json
  def new
    @article_rating = ArticleRating.new
    
    #need to calculate position
    
#    position = 0
    
    @articleRatings_old = ArticleRating.find(:all, :conditions => [ "participant_id = ?", @participant.id], :group => 'article_id')
    
    if @articleRatings_old != nil
      @position = @articleRatings_old.size      
    else
      @position = 0
    end

    
##    
      
      @articleContentRatings_old = ArticleContentRating.find(:all, :conditions => [ "participant_id = ?", @participant.id], :group => 'article_id')
      
        
      if @articleRatings_old != nil and @articleRatings_old.size >= 3
        redirect_to new_participant_demographic_path(@participant)
      
      elsif @position == @articleContentRatings_old.size
            article_within_type_id_array=@participant.article_within_type_id_array.split(",").map(&:to_i)
            article_type_id_array=@participant.article_type_id_array.split(",").map(&:to_i)
            @article = Article.find(:first, :conditions => [ "within_type_id = ? AND type_id=?", article_within_type_id_array[@position],article_type_id_array[@position]])
        #    @article = Article.where("within_type_id=? AND type_id=?",1, 1)  
        #    @article = Article.find(1)      

            @article_rating.article_id = @article.id

            respond_to do |format|
              format.html # new.html.erb
              format.json { render :json => @article_rating }
            end        
      else
        redirect_to new_participant_article_rating_article_content_rating_path(@participant, @articleRatings_old.first)   
      end  

  end

  # POST /article_ratings
  # POST /article_ratings.json
  def create
    @article_rating = ArticleRating.new(params[:article_rating])
    @article_rating.participant_id = @participant.id


    respond_to do |format|
      if @article_rating.save
        format.html { redirect_to new_participant_article_rating_article_content_rating_path(@participant, @article_rating) }
#        format.html { redirect_to new_participant_article_content_rating_path(@participant) }
        format.json { render :json => @article_rating, :status => :created, :location => @article_rating }
      else
        @article = Article.find(@article_rating.article_id)
        @articleRatings_old = ArticleRating.find(:all, :conditions => [ "participant_id = ?", @participant.id], :group => 'article_id')

        if @articleRatings_old != nil
          @position = @articleRatings_old.size      
        else
          @position = 0
        end
        format.html { render :action => "new" }
        format.json { render :json => @article_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /article_ratings/1
  # PUT /article_ratings/1.json
  def update
    @article_rating = ArticleRating.find(params[:id])

    respond_to do |format|
      if @article_rating.update_attributes(params[:article_rating])
        format.html { redirect_to @article_rating }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @article_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  private
                    
    def get_participant
      @participant = Participant.find(:first, :conditions => [ "id = ?", params[:participant_id]])
    end
end
