Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :products do
    collection do
      get :filter
    end
  end

  resources :users, only: [:show, :edit, :update]
  resource :user_infos, only: [:edit, :update]
  resource :payment_infos, only: [:edit, :update]

  resources :cart_items, only: [:index, :create, :destroy] do
    patch :increment_quantity, on: :member
    patch :decrement_quantity, on: :member
  end

  root to: 'products#index'
  get 'products/by_category/:category', to: 'products#by_category', as: 'products_by_category'
  get '/cart_items/checkout', to: 'cart_items#checkout', as: 'cart_items_checkout'
  get '/profile', to: 'users#profile', as: 'user_profile'
end
