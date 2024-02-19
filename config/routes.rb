Rails.application.routes.draw do
  devise_for :users
  
  root to: "home#index"
  
  resources :buses do
    member do
      post 'create_reservation'
      get 'search'
    end
    resources :reservations, only: [:create, :destroy]
    resources :reservations, only: [:index, :destroy]
    get 'reservations_for_date', on: :member
  end
  
  end

  resources :reservations, only: [:index, :destroy]

  namespace :bus_owner do
    resources :buses, only: [:index, :show] do
      resources :reservations, only: [:index]
    end
  end

  get '/lists', to: 'home#list', as: 'home_list'
end

