Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :products, only: [:index, :show]
  
  # Admin routes
  namespace :admin do
    resources :products do
      member do
        get :manage_images
        post :attach_images
        delete :remove_image
      end
    end

    get 'logo', to: 'settings#logo'
    patch 'logo', to: 'settings#update_logo'
    delete 'logo', to: 'settings#destroy_logo'
  end
  
  # Health check
  get "health", to: proc { [200, {}, ["OK"]] }
end