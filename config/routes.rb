Rails.application.routes.draw do
  root 'home#home'
  get 'login', to: 'login#login'
  post 'login', to: 'login#create'
  post 'logout', to: 'login#destroy'
  resources :users
end
