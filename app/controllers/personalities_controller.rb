class PersonalitiesController < ApplicationController
  before_filter :get_participant
  protect_from_forgery :except => [:new, :create, :index]
  
  # GET /personalities
  # GET /personalities.json
  def index
    @personalities = Personality.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @personalities }
    end
  end

  # GET /personalities/new
  # GET /personalities/new.json
  def new
    @personality = Personality.new
    
    if (personality_old=Personality.find(:last, :conditions => [ "participant_id = ?", @participant.id])) != nil
      @personality = personality_old.dup
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @personality }
    end
  end

  # POST /personalities
  # POST /personalities.json
  def create
    @personality = Personality.new(params[:personality])
    @personality.participant_id = @participant.id

    respond_to do |format|
      if @personality.save
        format.html { redirect_to new_participant_value_path(@participant) }
        format.json { render :json => @personality, :status => :created, :location => @personality }
      else
        format.html { render :action => "new" }
        format.json { render :json => @personality.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  # PUT /personalities/1
  # PUT /personalities/1.json
#  def update
#    @personality = Personality.find(params[:id])
#
#    respond_to do |format|
#      if @personality.update_attributes(params[:personality])
#        format.html { redirect_to new_participant_value_path(@participant) }
#        format.json { head :no_content }
#      else
#        format.html { render :action => "edit" }
#        format.json { render :json => @personality.errors, :status => :unprocessable_entity }
#      end
#   end
#  end


  
  private
                    
    def get_participant
      @participant = Participant.find(:first, :conditions => [ "id = ?", params[:participant_id]])
    end
end
