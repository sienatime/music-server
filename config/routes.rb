Rails.application.routes.draw do
  root to: "home#index"

  get '/import', to: 'home#import'

  resources :artists, only: [:index, :show]
  resources :albums, only: [:index, :show]
  resources :songs do
    collection do
      get 'download'
    end
  end
end
