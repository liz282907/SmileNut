Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'

  get 'account/login'

  get 'account/register' 

  get 'activites/all-events'
  
  get 'account/showUnreadMessage'
  
  get 'signup' => 'users#new'
  # post 'activites/add_in_comment'
  
  resources :activites do
   post :add_in_comment #-> url.com/activities/:activity_id/add_in_comment
end
  
  get 'launch' => 'activites#new'
  
#  post 'activites/all-events'

  get 'nuts/index'

  get 'hole/all-holes'
    
  post 'account/login'

  post 'account/register'
  
  post 'activites/add'
  
  # get 'account/logout'
  
  
  
  delete 'activites/delete'

  post 'activites/add_comment'
  
  get 'nuts/user_profile'
  get 'nuts/user_profile_tab'
  post 'nuts/user_profile'
  
  get 'login' => 'sessions#new' 
  post 'login' => 'sessions#create' 
  #delete 'logout' => 'sessions#destroy'
  get 'logout' => 'sessions#destroy'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

    root 'nuts#index'
    resources :nuts
    # resources :activites
    resources :hole
    resources :account
    resources :users
    
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
