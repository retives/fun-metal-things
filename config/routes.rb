Rails.application.routes.draw do
  get "items/index"
  get "items/show"
  devise_for :users
  # Items routes + reviews
  resources :items, only: [ :index, :show ] do
    resources :reviews, outline: [ :create ]
  end
  # Cart items routes
  resources :cart_items, only: [ :create, :destroy, :update ]
  # Cart routes
  resource :cart, only: [ :show ]
  # Profile routes
  resource :profile, only: [ :show, :edit, :update ]

  # Order routes + payment
resources :orders, only: [:new, :create, :show] do
    member do
      get 'payment', as: 'payment' 
      get 'confirm_payment' 
    end
  end
  # Admin routes
  namespace :admin do
    root to: "dashboard#index"
    resources :items
    resources :orders, only: [ :index, :show, :update ] # Додано :update
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")

  root "items#index"
end
