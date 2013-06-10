class TwitterChecksController < ApplicationController
  before_filter :get_participant
  protect_from_forgery :except => [:new, :create, :index]
  
  # GET /twitter_checks
  # GET /twitter_checks.json
  def index
    @twitter_checks = TwitterCheck.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @twitter_checks }
    end
  end

  # GET /twitter_checks/1
  # GET /twitter_checks/1.json
  def show
    @twitter_check = TwitterCheck.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @twitter_check }
    end
  end

  # GET /twitter_checks/new
  # GET /twitter_checks/new.json
  def new
    @twitter_check = TwitterCheck.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @twitter_check }
    end
  end

  # GET /twitter_checks/1/edit
  def edit
    @twitter_check = TwitterCheck.find(params[:id])
  end

  # POST /twitter_checks
  # POST /twitter_checks.json
  def create
    @twitter_check = TwitterCheck.new(params[:twitter_check])

    respond_to do |format|
      if @twitter_check.save
        format.html { redirect_to @twitter_check, :notice => 'Twitter check was successfully created.' }
        format.json { render :json => @twitter_check, :status => :created, :location => @twitter_check }
      else
        format.html { render :action => "new" }
        format.json { render :json => @twitter_check.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /twitter_checks/1
  # PUT /twitter_checks/1.json
  def update
    @twitter_check = TwitterCheck.find(params[:id])

    respond_to do |format|
      if @twitter_check.update_attributes(params[:twitter_check])
        format.html { redirect_to @twitter_check, :notice => 'Twitter check was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @twitter_check.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /twitter_checks/1
  # DELETE /twitter_checks/1.json
  def destroy
    @twitter_check = TwitterCheck.find(params[:id])
    @twitter_check.destroy

    respond_to do |format|
      format.html { redirect_to twitter_checks_url }
      format.json { head :no_content }
    end
  end
  
  
  private
                    
    def get_participant
      @participant = Participant.find(:first, :conditions => [ "id = ?", params[:participant_id]])
    end
end
