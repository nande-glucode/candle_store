Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :products, only: [:index, :show]
  resources :cart_items, only: [:index, :create, :update, :destroy]

  get '/checkout', to: 'checkout#new', as: 'checkout'
  post '/checkout', to: 'checkout#create'
  get '/checkout/confirmation/:id', to: 'checkout#confirmation', as: 'checkout_confirmation'
  
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