class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    
    @user = current_user
    
    @tweets =  current_user.getMostRecent()
#   @tweets.each do |tweet|
#     newTweet = Tweets.new(:id => tweet.id, :text => tweet.text, :favorites_count => tweet.favorites_count, 
#     :retweet_count => tweet.retweet_count, :time =>tweet.created_at, :user_uid => current_user.uid)
#     newTweet.save!
#   end

    @userinfo = current_user.getUserInfo()
    
    if @tweets.count > 200 and (DateTime.now - @userinfo.created_at) > 5.days
           redirect_to participant_users_path(@participant), :error => 'not verified.' 
#      respond_to do |format|
#        format.html # show.html.erb
#        format.json { render :json => @user }
#      end
    else
      redirect_to participant_users_path(@participant), :error => 'not verified.' 
    end
    


  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
#  def getMostRecent
#    if !current_user
#      redirect_to root_url, :notice => "Please log in first."
#    else
#        current_user.getMostRecent()
#        redirect_to user_path(user.id), :notice => "I tweeted that."
#    end
#  end
end
