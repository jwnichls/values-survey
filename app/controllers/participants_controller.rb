class ParticipantsController < ApplicationController
  protect_from_forgery :except => [:new, :create, :index]

  # GET /participants
  # GET /participants.json
  def index
    @participants = Participant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @participants }
    end
  end


  # GET /participants/new
  # GET /participants/new.json
  def new
    @participant = Participant.new

    @participant.assignment_id = params[:assignmentId]
    @participant.hit_id = params[:hitId]
    @participant.worker_id = params[:workerId]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @participant }
    end
  end


  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.new(params[:participant])
    

    
    @participant_old = Participant.find(:first, :conditions => [ "worker_id = ?", @participant.worker_id])
    if @participant.worker_id != "" && @participant_old != nil
      @participant = @participant_old
    else
      article_type_id_array=(1..3).to_a
      article_type_id_array = article_type_id_array.sort_by { rand }

      article_within_type_id_array=[rand(3)+1,rand(3)+1,rand(3)+1]

      @participant.article_type_id_array = article_type_id_array.join(",")
      @participant.article_within_type_id_array = article_within_type_id_array.join(",")
    end
    

    respond_to do |format|
      if @participant.save
        format.html { redirect_to new_participant_twitter_check_path(@participant.id) }
        format.json { render :json => @participant, :status => :created, :location => @participant }
      else
        format.html { render :action => "new" }
        format.json { render :json => @participant.errors, :status => :unprocessable_entity }
      end
    end
  end

end
