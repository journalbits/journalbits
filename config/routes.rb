JournalBits::Application.routes.draw do

  resources :lastfm_entries

  resources :instapaper_entries

  resources :instagram_entries

  resources :evernote_entries

  resources :whatpulse_entries

  resources :facebook_photo_entries

  resources :pocket_entries

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :users do  
    resources :twitter_entries
    resources :rescue_time_entries
    resources :github_entries
    resources :fitbit_weight_entries
    resources :fitbit_activity_entries
    resources :fitbit_sleep_entries
    resources :wunderlist_entries
  end
  
  root :to => "home#index"

  get 'auth/github' => 'authorization#github'
  get 'connections' => 'authorization#index'
  get 'auth/rescue_time' => 'authorization#rescue_time'
  get 'auth/wunderlist' => 'authorization#wunderlist'
  get 'auth/whatpulse' => 'authorization#whatpulse'
  patch 'auth/wunderlist' => 'users#wunderlist_update'
  patch 'auth/rescue_time' => 'users#rescue_time_update'
  patch 'auth/whatpulse' => 'users#whatpulse_update'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
