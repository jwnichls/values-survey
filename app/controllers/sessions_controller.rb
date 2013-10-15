class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    temp_id = params[:participant_id]
    user = User.find_by_uid(auth["uid"]) || User.create_with_omniauth(auth, temp_id.to_i)

    user.token = auth["credentials"]["token"]
    user.secret = auth["credentials"]["secret"]
    user.save!
#    user.participant_id = params[:participant_id]
    session[:user_id] = user.id
    
    @tweets =  user.getMostRecent()
    
    @tweets.each do |tweet|
      newTweet = Tweets.new(:id => tweet.id, :text => tweet.text, :favorites_count => tweet.favorites_count, 
      :retweet_count => tweet.retweet_count, :time =>tweet.created_at, :user_uid => user.uid)
      newTweet.save
    end
    
    @userinfo = user.getUserInfo()
    @participant = Participant.find(params[:participant_id])
    
    # t = DateTime.parse(@userinfo.created_at)
     if @tweets.count > 100 and (DateTime.now - @userinfo.created_at.to_datetime).to_i > 28
       
        ## check if id has already used before
        if temp_id == user.participant_id

          ## new participant
          redirect_to new_participant_personality_path(user.participant_id), :notice => "Your Twitter account meets the study requirement!"

          ## check if study has already been completed

        else

          if (demographic_old=Demographic.find(:last, :conditions => [ "participant_id = ?", user.participant_id])) != nil
            #@demographic = demographic_old.dup
            redirect_to new_twitter_check_path(:worker_id=>@participant.worker_id,:hit_id=>@participant.hit_id,:assignment_id=>@participant.assignment_id), :alert => "Your Twitter account has already been used for this experiment! If this is an error, please contact garyhsieh@gmail.com"
        
          else        

            redirect_to new_participant_personality_path(user.participant_id), :notice => "Your Twitter account meets the study requirement!"          end
        end
     else

       redirect_to new_twitter_check_path(:worker_id=>@participant.worker_id,:hit_id=>@participant.hit_id,:assignment_id=>@participant.assignment_id), :alert => 'Your Twitter account does not meet the study requirement!' 
     end  
  end
  
end
