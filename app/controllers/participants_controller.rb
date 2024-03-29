class ParticipantsController < ApplicationController
  protect_from_forgery :except => [:new, :create, :index, :show]

  # GET /participants
  # GET /participants.json
  def index
    @participants = Participant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @participants }
    end
  end

  def show
    @participant = Participant.find(params[:id])
  end


  # GET /participants/new
  # GET /participants/new.json
  def new
    @participant = Participant.new


    @participant.assignment_id = params[:assignmentId]
    @participant.hit_id = params[:hitId]
    @participant.worker_id = params[:workerId]
    @participant.article_type_id_array = request.remote_ip

    @participant_old = Participant.find(:first, :conditions => [ "worker_id = ? AND id < 750", @participant.worker_id])


    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @participant }
    end
  end


  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.new(params[:participant])
    

    
    @participant_old = Participant.find(:first, :conditions => [ "worker_id = ? AND id < 750", @participant.worker_id])
#    if @participant_old != nil
#      @participant_old.condition = @participant.condition
#      @participant = @participant_old.dup
#    end

    if @participant.save

      ##uncomment for live
      #redirect_to('https://www.mturk.com/mturk/externalSubmit?condition='+@participant.condition.to_s+'&id='+@participant.id.to_s+'&assignmentId=' + @participant.assignment_id)
      
      ##uncomment for sandbox
      #redirect_to('https://workersandbox.mturk.com/mturk/externalSubmit?condition='+@participant.condition.to_s+'&id='+@participant.id.to_s+'&assignmentId=' + @participant.assignment_id)

      redirect_to('https://www.mturk.com/mturk/externalSubmit?condition='+@participant.condition.to_s+'&participantId='+@participant.id.to_s+'&assignmentId='+@participant.assignment_id.to_s+'&hitId='+@participant.hit_id.to_s+'&workerId='+@participant.worker_id.to_s+'') 
      #format.json { render :json => @participant, :status => :created, :location => @participant }

      #redirect_to(participant_path(@participant.id)) 

    else
      render :action => "new" 
    end


#    else


#      article_type_id_array=(1..3).to_a
#      article_type_id_array = article_type_id_array.sort_by { rand }

#      article_within_type_id_array=[rand(3)+1,rand(3)+1,rand(3)+1]

#      @participant.article_type_id_array = article_type_id_array.join(",")
#      @participant.article_within_type_id_array = article_within_type_id_array.join(",")
#    end
    


  end

end
