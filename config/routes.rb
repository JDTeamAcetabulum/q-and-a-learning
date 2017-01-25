Rails.application.routes.draw do
  get 'login', to: 'login#login'

  root 'home#home'
end
