Rails.application.routes.draw do
  root 'login#login'
  get '/home', to: 'home#home'
  get '/register', to: 'users#new'
  post '/register',  to: 'users#create'
  get '/login', to: 'login#login'
  post '/login', to: 'login#create'
  delete '/logout', to: 'login#destroy'

  get'questions/short', as: :short_question
  
  resources :users
  resources :questions
end
