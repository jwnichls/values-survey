class ValuesController < ApplicationController
  before_filter :get_participant
  protect_from_forgery :except => [:new, :create, :index]


  # GET /values/new
  # GET /values/new.json
  def new
    @value = Value.new

    @values_array=(0..20).to_a
    @values_array = @values_array.sort_by { rand }    
    @values_array.push(21)
    
    if (value_old=Value.find(:last, :conditions => [ "participant_id = ?", @participant.id])) != nil
#      @value = value_old.dup
       #redirect_to participant_article_ratings_path(@participant)
      redirect_to new_participant_demographic_path(@participant)
    else

      @personality = Personality.find(:last, :conditions => [ "participant_id = ?", @participant.id])
      if @personality != nil
        respond_to do |format|
          format.html # new.html.erb
          format.json { render :json => @value }
        end
      else
        redirect_to new_participant_personality_path(@participant.id)
      end

    end
    

  end

  # POST /values
  # POST /values.json
  def create
    @value = Value.new(params[:value])
    @value.participant_id = @participant.id
    @personality = Personality.find(:last, :conditions => [ "participant_id = ?", @participant.id])
    

    @values_array=(0..20).to_a
    @values_array = @values_array.sort_by { rand }    
    @values_array.push(21)    
    
    respond_to do |format|
      if @value.save
        format.html {       redirect_to new_participant_demographic_path(@participant) }
        format.json { render :json => @value, :status => :created, :location => @value }
      else
        format.html { render :action => "new" }
        format.json { render :json => @value.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
#  # PUT /values/1
#  # PUT /values/1.json
#  def update
#    @value = Value.find(params[:id])
#
#    respond_to do |format|
#      if @value.update_attributes(params[:value])
#        format.html { redirect_to participant_article_ratings_path(@participant)}
#        format.json { head :no_content }
#      else
#        format.html { render :action => "edit" }
#        format.json { render :json => @value.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  
  private
                    
    def get_participant
      @participant = Participant.find(:first, :conditions => [ "id = ?", params[:participant_id]])
    end
end
