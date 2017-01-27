Rails.application.routes.draw do
  root 'login#login'
  get '/home', to: 'home#home'
  get '/signup', to: 'users#new'
  get '/login', to: 'login#login'
  post '/login', to: 'login#create'
  delete '/logout', to: 'login#destroy'
  resources :users
end
