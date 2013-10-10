Goals::Application.routes.draw do
  root to: 'home#index'

  resource :users
  resource :sessions, only: [:create]

  get '/signup' => 'users#new', as: 'signup'
  get '/login' => 'sessions#new', as: 'login'
  delete '/logout' => 'sessions#destroy'

  get 'auth/:provider/callback' => 'oauth#create'
  get 'auth/failure' => 'oauth#fail'
  get '/auth/facebook', as: 'facebook_oauth'

  resources :goals
  get '/show_goal' => 'goals#show_goal'
  post '/add_goal_detail' => 'goals#add_goal_detail'
  put '/edit_object' => 'goals#edit_object'

end
