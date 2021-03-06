Rails.application.routes.draw do

  get 'sessions/new' => 'sessions#new'
  post 'sessions/create' => 'sessions#create'
  delete 'sessions/destroy' => 'sessions#destroy'

  get '/users' => 'users#index'
  get '/professional_profile' => 'users#professional_profile'
  get 'users/:user_id/edit' => 'users#edit'
  post 'users/create' => 'users#create'
  patch 'users/:user_id' => 'users#update'
  get 'users/:user_id' => 'users#show'

  get '/invitations/:invitee_id' => 'invitations#create'

  get '/ignoreds/:ignoree_id' => 'ignoreds#create'

  #this line needs to be changed
  get '/put_main_index_path_here' => 'users#temporary'


  get 'users/create'

  get 'users/show'

  get 'users/edit'

  get 'users/update'

  get 'users/destroy'

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

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
