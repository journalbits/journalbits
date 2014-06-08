JournalBits::Application.routes.draw do

  use_doorkeeper do
    controllers :applications => 'oauth/applications'
  end

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: "registrations" }

  root :to => "days#index"

  get 'connections' => 'authorization#index'
  get 'auth/github' => 'authorization#github'
  get 'auth/rescue_time' => 'authorization#rescue_time'
  get 'auth/wunderlist' => 'authorization#wunderlist'
  get 'auth/whatpulse' => 'authorization#whatpulse'
  get 'auth/clef/callback' => 'users#clef'

  patch 'auth/wunderlist' => 'users#wunderlist_update'
  patch 'auth/rescue_time' => 'users#rescue_time_update'
  patch 'auth/whatpulse' => 'users#whatpulse_update'

  resources :users,  path: "" do
    resources :days, path: ""

    resources :twitter_entries
    resources :rescue_time_entries
    resources :github_entries
    resources :fitbit_weight_entries
    resources :fitbit_activity_entries
    resources :fitbit_sleep_entries
    resources :wunderlist_entries
    resources :lastfm_entries
    resources :instapaper_entries
    resources :instagram_entries
    resources :evernote_entries
    resources :whatpulse_entries
    resources :facebook_photo_entries
    resources :pocket_entries
    resources :health_graph_entries
    resources :moves_entries
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :user

    end
  end

end
