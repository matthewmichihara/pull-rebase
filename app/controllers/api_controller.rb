class ApiController < ApplicationController
  
  def twitter_user_timeline
    if twitter.nil?
      respond_to do |format|
        format.json { render :json => "[]".to_json }
      end
    else
      respond_to do |format|
        format.json { render :json => twitter.home_timeline(params).to_json }
      end
    end
  end

  def facebook_feed
    if facebook.nil?    
      respond_to do |format|
        format.json { render :json => "[]".to_json }
      end
    else
      respond_to do |format|
        format.json { render :json => facebook.get_connections("me", "home", :since => 1334128363).to_json }
      end
    end
  end
end
