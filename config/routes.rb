require 'sidekiq/web'

JournalBits::Application.routes.draw do

  use_doorkeeper do
    controllers :applications => 'oauth/applications'
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: "registrations" }

  root :to => "days#index"

  get 'test' => 'authorization#test'

  get 'connections' => 'authorization#index'
  get 'auth/github' => 'authorization#github'
  get 'auth/rescue_time' => 'authorization#rescue_time'
  get 'auth/wunderlist' => 'authorization#wunderlist'
  get 'auth/whatpulse' => 'authorization#whatpulse'
  get 'auth/clef/callback' => 'users#clef'

  patch 'auth/wunderlist' => 'users#wunderlist_update'
  patch 'auth/rescue_time' => 'users#rescue_time_update'
  patch 'auth/whatpulse' => 'users#whatpulse_update'


  post 'users/reauth/evernote' => 'evernote_accounts#reauthorize'

  resources :users,  path: "" do
    resources :evernote_entries
    resources :facebook_photo_entries
    resources :fitbit_activity_entries
    resources :fitbit_sleep_entries
    resources :fitbit_weight_entries
    resources :github_entries
    resources :health_graph_entries
    resources :instapaper_entries
    resources :instagram_entries
    resources :lastfm_entries
    resources :moves_entries
    resources :pocket_entries
    resources :rescue_time_entries
    resources :twitter_entries
    resources :whatpulse_entries
    resources :wunderlist_entries

    resources :evernote_accounts
    resources :facebook_accounts
    resources :fitbit_accounts
    resources :github_accounts
    resources :health_graph_accounts
    resources :instagram_accounts
    resources :instapaper_accounts
    resources :lastfm_accounts
    resources :moves_accounts
    resources :pocket_accounts
    resources :rescue_time_accounts
    resources :twitter_accounts
    resources :whatpulse_accounts
    resources :wunderlist_accounts

    resources :days, path: ""
  end


  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      # Maybe need to set the paths to "" as above
      resources :user do
        resources :days

        resources :evernote_entries
        resources :facebook_photo_entries
        resources :fitbit_activity_entries
        resources :fitbit_sleep_entries
        resources :fitbit_weight_entries
        resources :github_entries
        resources :health_graph_entries
        resources :instapaper_entries
        resources :instagram_entries
        resources :lastfm_entries
        resources :moves_entries
        resources :pocket_entries
        resources :rescue_time_entries
        resources :twitter_entries
        resources :whatpulse_entries
        resources :wunderlist_entries
      end
    end
  end
end
