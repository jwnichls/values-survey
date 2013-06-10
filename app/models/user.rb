class User < ActiveRecord::Base
  # attr_accessible :title, :body
  def self.create_with_omniauth(auth, temp_id)
    create! do |user|
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.nickname = auth["info"]["nickname"]
      user.token = auth["credentials"]["token"]
      user.secret = auth["credentials"]["secret"]
      user.participant_id = temp_id
    end
  end
  
  def getMostRecent()
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY'] 
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET'] 
      config.oauth_token = self.token
      config.oauth_token_secret = self.secret
    end

    client = Twitter::Client.new
    client.user_timeline
  end
  
  def getUserInfo()
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY'] 
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET'] 
      config.oauth_token = self.token
      config.oauth_token_secret = self.secret
    end

    client = Twitter::Client.new
    client.user(self.uid.to_i)
  end
end
