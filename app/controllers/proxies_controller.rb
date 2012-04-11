class ProxiesController < ApplicationController
  
  def twitter_user_timeline
    unless twitter.nil?
      respond_to do |format|
        format.json { render :json => twitter.home_timeline(params).to_json }
      end
    end
  end

  def facebook_feed
    unless facebook.nil?    
      respond_to do |format|
        format.json { render :json => facebook.get_connections("me", "home").to_json }
      end
    end
  end
end
