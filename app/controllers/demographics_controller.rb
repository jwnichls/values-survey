class DemographicsController < ApplicationController
  before_filter :get_participant
  protect_from_forgery :except => [:new, :create, :index]
  
  # GET /demographics
  # GET /demographics.json
  def index
    @demographics = Demographic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @demographics }
    end
  end


  # GET /demographics/new
  # GET /demographics/new.json
  def new
    @demographic = Demographic.new


    if (demographic_old=Demographic.find(:last, :conditions => [ "participant_id = ?", @participant.id])) != nil
#      @demographic = demographic_old.dup
       redirect_to participant_demographics_path(@participant.id)
    
    else


      respond_to do |format|
        format.html # new.html.erb
        format.json { render :json => @demographic }
      end
    end
  end


  # POST /demographics
  # POST /demographics.json
  def create
    @demographic = Demographic.new(params[:demographic])
    @demographic.participant_id = @participant.id

    respond_to do |format|
      if @demographic.save
        format.html { redirect_to participant_demographics_path(@participant.id), :notice => 'HIT Submitted' }
        format.json { render :json => @demographic, :status => :created, :location => @demographic }
      else
        format.html { render :action => "new" }
        format.json { render :json => @demographic.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
#  # PUT /demographics/1
#  # PUT /demographics/1.json
#  def update
#    @demographic = Demographic.find(params[:id])

#    respond_to do |format|
#      if @demographic.update_attributes(params[:demographic])
#        format.html { redirect_to participant_demographics_path(@participant.id), :notice => 'HIT Submitted' }
#        format.json { head :no_content }
#      else
#        format.html { render :action => "edit" }
#        format.json { render :json => @demographic.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  
  private
                    
    def get_participant
      @participant = Participant.find(:first, :conditions => [ "id = ?", params[:participant_id]])
    end
end
