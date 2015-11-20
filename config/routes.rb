Rails.application.routes.draw do
  
  root 'homes#index'
  devise_for :users
  
  resources :homes, only:[:index] do
    collection do 
      put 'update_metals'
      get 'update_variants_value', as: :update_variants_value
      put 'update_variants_value'
    end
  end
end
