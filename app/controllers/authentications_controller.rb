class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications
  end

  def create
    auth = request.env["omniauth.auth"] 
    provider = auth['provider']
    token = auth['credentials']['token']
    secret = auth['credentials']['secret']
    current_user.authentications.find_or_create_by_provider_and_access_token_and_access_secret(provider, token, secret)
    flash[:notice] = "Authentication successful"
    redirect_to authentications_url
  end

  def destroy
  end
end
