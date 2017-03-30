Rails.application.routes.draw do
  root 'login#login'
  get '/home', to: 'home#home'
  get '/register', to: 'users#new'
  post '/register',  to: 'users#create'
  get '/login', to: 'login#login'
  post '/login', to: 'login#create'
  delete '/logout', to: 'login#destroy'

  resources :users
  resources :questions do
    collection do
      get 'export'
    end
  end
  get 'questions/short', as: :short_question
  post 'questions/submit', to: 'questions#submit_question', as: :submit_question
  post 'questions/export', to: 'questions#build_csv', defaults: { format: 'csv' }
end
