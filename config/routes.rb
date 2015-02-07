require 'sidekiq/web'

JournalBits::Application.routes.draw do

  use_doorkeeper do
    controllers :applications => 'oauth/applications'
  end

  # authenticate :user, lambda { |u| u.admin? } do
  # end
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: "registrations" }

  authenticated do
    root to: 'days#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'home#index'
  end

  get 'test' => 'authorization#test'

  get 'connections' => 'authorization#index'
  get 'auth/clef/callback' => 'users#clef'

  get '/users/auth/check/:provider' => 'authorization#check'

  get 'users/auth/whatpulse' => 'authorization#whatpulse'
  get 'users/auth/wunderlist' => 'authorization#wunderlist'
  get 'users/auth/rescuetime' => 'authorization#rescue_time'

  post 'users/reauth/evernote' => 'evernote_accounts#reauth'
  post 'users/reauth/facebook' => 'facebook_accounts#reauth'
  post 'users/reauth/fitbit' => 'fitbit_accounts#reauth'
  post 'users/reauth/github' => 'github_accounts#reauth'
  post 'users/reauth/healthgraph' => 'health_graph_accounts#reauth'
  post 'users/reauth/instagram' => 'instagram_accounts#reauth'
  post 'users/reauth/instapaper' => 'instapaper_accounts#reauth'
  post 'users/reauth/lastfm' => 'lastfm_accounts#reauth'
  post 'users/reauth/moves' => 'moves_accounts#reauth'
  post 'users/reauth/pocket' => 'pocket_accounts#reauth'
  post 'users/reauth/twitter' => 'twitter_accounts#reauth'
  post 'users/reauth/wunderlist' => 'wunderlist_accounts#reauth'

  get '/about' => 'footer#about'
  get '/support' => 'footer#support'

  namespace :onboarding do
    get 'setup_connections'
  end

  namespace :pusher do
    post 'auth'
  end

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
