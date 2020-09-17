Rails.application.routes.draw do
  root to: "home#index"

  get '/import', to: 'home#import'

  get 'artists/index'
  get 'artists/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
