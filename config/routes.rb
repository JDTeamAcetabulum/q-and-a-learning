Rails.application.routes.draw do
  resources :questions
  root 'application#hello'
end
