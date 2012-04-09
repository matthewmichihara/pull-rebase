class ProxiesController < ApplicationController
  def twitter_client(access_token, access_secret)
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.oauth_token = access_token
      config.oauth_token_secret = access_secret
    end

    Twitter::Client.new
  end

  def twitter_user_timeline
    @twitter = nil
    current_user.authentications.each do |auth|
      if auth.provider == 'twitter'
        @twitter = twitter_client(auth.access_token, auth.access_secret)
      end
    end

    respond_to do |format|
      format.json { render :json => @twitter.home_timeline.to_json }
    end
  end
end
