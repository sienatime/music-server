Rails.application.routes.draw do
  root to: "home#index"

  get '/import', to: 'home#import'

  get '/search', to: 'search#query'

  resources :artists, only: [:index, :show]
  resources :albums, only: [:index, :show]
  resources :songs, only: [:index] do
    collection do
      get 'download'
    end
  end
end
