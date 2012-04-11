Merge::Application.routes.draw do
  root :to => "home#index"
  devise_for :users

  get "api/twitter_user_timeline"
  get "api/facebook_feed"

  resources :authentications

  match "/auth/:provider/callback" => "authentications#create"
end
