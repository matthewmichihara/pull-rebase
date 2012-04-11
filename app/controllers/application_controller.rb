class ApplicationController < ActionController::Base
  protect_from_forgery

  @@twitter = nil
  @@facebook = nil

  def init_twitter(access_token, access_secret)
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.oauth_token = access_token
      config.oauth_token_secret = access_secret
    end

    @@twitter ||= Twitter::Client.new
  end

  def init_facebook(access_token)
    @@facebook ||= Koala::Facebook::API.new(access_token)
  end

  helper_method :twitter
  
  def twitter
    @@twitter
  end

  helper_method :facebook

  def facebook
    @@facebook
  end
end
