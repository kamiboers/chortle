Rails.application.routes.draw do
  get 'users/create'

  get 'users/update'

  get 'users/destroy'

  # get 'sessions/create'


  post '/login', to: 'sessions#create', as: 'login'
  get 'sessions/update'
  get 'sessions/destroy'
  
  post '/create_user', to: 'users#create', as: 'create_user'
  get 'user/update'
  get 'user/destroy'

  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
