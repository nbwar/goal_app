Goals::Application.routes.draw do
  root to: 'home#index'

  resource :users
  resource :sessions, only: [:create]

  get '/signup' => 'users#new', as: 'signup'
  get '/login' => 'sessions#new', as: 'login'
  delete '/logout' => 'sessions#destroy'

  resources :goals
  get '/show_goal' => 'goals#show_goal'

end
