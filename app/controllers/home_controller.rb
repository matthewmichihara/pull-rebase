class HomeController < ApplicationController
  before_filter :authenticate_user!

  def twitter_client(access_token, access_secret)
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.oauth_token = access_token
      config.oauth_token_secret = access_secret
    end

    Twitter::Client.new
  end

  def index
    @twitter = nil
    current_user.authentications.each do |authentication|
      if authentication.provider == 'twitter'
        @twitter = twitter_client(authentication.access_token, authentication.access_secret)
      end
    end
  end
end
