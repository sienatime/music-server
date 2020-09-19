Rails.application.routes.draw do
  root to: "home#index"

  get '/import', to: 'home#import'

  resources :artists, only: [:index, :show]
  resources :albums, only: [:index, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
