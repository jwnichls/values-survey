class TwitterChecksController < ApplicationController
#  before_filter :get_participant
  protect_from_forgery :except => [:new, :create, :index]


  # GET /twitter_checks/new
  # GET /twitter_checks/new.json
  def new
    @twitter_check = TwitterCheck.new

    @participant = Participant.new
    @participant.assignment_id = params[:assignmentId]
    @participant.hit_id = params[:hitId]
    @participant.worker_id = params[:workerId]
    @participant.condition = request.remote_ip.gsub '.',''


    @participant_old = Participant.find(:first, :conditions => [ "worker_id = ?", @participant.worker_id])
    if @participant.worker_id != "" && @participant_old != nil
      @participant = @participant_old
    else
      article_type_id_array=(4..5).to_a
      article_type_id_array = article_type_id_array.sort_by { rand }

      article_within_type_id_array=[rand(3)+1,rand(3)+1]

      @participant.article_type_id_array = article_type_id_array.join(",")
      @participant.article_within_type_id_array = article_within_type_id_array.join(",")
    end

    @participant.save

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @twitter_check }
    end
  end


  # POST /twitter_checks
  # POST /twitter_checks.json
  def create
##    @twitter_check = TwitterCheck.new(params[:twitter_check])

    @participant = Participant.find(params[:twitter_check][:participant_id])

    if @participant != nil
      redirect_to new_participant_personality_path(@participant) 
    else
      render :action => "new"
    end
  end

  
  
 # private
 #                   
 #   def get_participant
 #     @participant = Participant.find(:first, :conditions => [ "id = ?", params[:participant_id]])
 #   end
end
