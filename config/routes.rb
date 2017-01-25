Rails.application.routes.draw do
  root 'home#home'
  get 'login', to: 'login#login'
  resources :users
end
