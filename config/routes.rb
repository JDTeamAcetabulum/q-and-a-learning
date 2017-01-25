Rails.application.routes.draw do
  resources :user_ids
  root 'application#hello'
end
