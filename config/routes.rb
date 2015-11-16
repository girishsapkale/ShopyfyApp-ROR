Rails.application.routes.draw do
  resources :orders
  resources :products
  resources :variants
  devise_for :users
 
  # Rails.application.routes.draw do
  resources :orders
  resources :products
  # devise_for :users
  #     devise_for :users, controllers: {
  #       sessions: 'users/sessions'
  #     }
  #   end

  resources :users
  resources :homes do
    collection do 
      get 'new_order'
      post 'create_order'
      post 'create_product'
      put 'update_product'
      put 'update_order'
    end
    member do
      get 'edit_order'
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'homes#index'

  # Example of regular route:
  get 'update_variants' => 'variants#update_variants', as: :update_variants
  put 'update_variants' => 'variants#update_variants'
  put 'variants_update' => 'variants#variants_update'
  get 'add_new_one' => 'homes#add_new_one'
  #get 'variants_update' => 'variants#variants_update', as: :variants_update
  
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
