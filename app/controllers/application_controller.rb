class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :init_clients
  protect_from_forgery

  def init_twitter(access_token, access_secret)
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.oauth_token = access_token
      config.oauth_token_secret = access_secret
    end

    Twitter::Client.new
  end

  def init_facebook(access_token)
    Koala::Facebook::API.new(access_token)
  end

  def init_clients
    if current_user.nil?
      return
    end

    current_user.authentications.each do |auth|
      if auth.provider == 'twitter'
        @twitter ||= init_twitter(auth.access_token, auth.access_secret)
      end
    end

    current_user.authentications.each do |auth|
      if auth.provider == 'facebook'
        @facebook ||= init_facebook(auth.access_token)
      end
    end
  end
end
