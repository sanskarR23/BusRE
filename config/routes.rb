Rails.application.routes.draw do
  devise_for :users
  
  root to: "home#index"
  
  resources :buses do
    member do
      get 'search'
    end
    get 'reservations_for_date', on: :member
  end
  resources :reservations
  

  namespace :bus_owner do
    resources :buses, only: [:index, :show] do
      resources :reservations, only: [:index]
    end
  end
  resources :reservations, only: [:index, :destroy]
  get '/lists', to: 'home#list', as: 'home_list'
end

