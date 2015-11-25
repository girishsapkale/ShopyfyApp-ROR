Rails.application.routes.draw do
  
  
  root 'homes#index'
  devise_for :users
  resources :metals
  resources :homes, only:[:index] do
    collection do 
      put 'update_metals'
      get 'diamond_values'
      put 'update_variants_value'
      get 'shopify_url'
      get 'set_shop'
      get 'metals_list'
      put 'update_shopify_url'      
    end
  end

  resources :products do
    member do
      put 'update_metal_prices'
    end
    collection do
      get 'reload_products'     
    end
  end

  namespace :webhooks do
    post 'create_product'
    post 'update_product'
  end
end
