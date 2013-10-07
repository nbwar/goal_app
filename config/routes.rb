Goals::Application.routes.draw do
  root to: 'home#index'

  resource :users
  resource :sessions, only: [:create]

  resources :goals

  get '/signup' => 'users#new', as: 'signup'
  get '/login' => 'sessions#new', as: 'login'
  delete '/logout' => 'sessions#destroy'
end
