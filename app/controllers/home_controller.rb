class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    current_user.authentications.each do |auth|
      if auth.provider == 'twitter'
        init_twitter(auth.access_token, auth.access_secret)
      end
    end

    current_user.authentications.each do |auth|
      if auth.provider == 'facebook'
        init_facebook(auth.access_token)
      end
    end
  end
end
