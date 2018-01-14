Rails.application.routes.draw do
  
  root 'pages#home'
  
  post '/login', to: 'sessions#create', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  
  post '/create_user', to: 'users#create', as: 'create_user'
  get 'users/update'
  get 'users/destroy'

end
