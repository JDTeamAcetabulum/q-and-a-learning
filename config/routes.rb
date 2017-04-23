Rails.application.routes.draw do
  root 'login#login'
  get '/home', to: 'home#home'
  get '/register', to: 'users#new'
  post '/register',  to: 'users#create'
  get '/login', to: 'login#login'
  post '/login', to: 'login#create'
  delete '/logout', to: 'login#destroy'
  get '/statistics', to: 'statistics#index'
  get '/popup_question', to: 'questions#popup_question', :as => :popup_question
  get '/check_live_question', to: 'questions#check_live_question', :as => :check_live_question
  get '/get_popup_html', to: 'questions#get_popup_html'

  resources :users do
    collection {post :import}
  end
  resources :questions do
    collection do
      get 'export'
      get 'import'
    end
  end
  get 'questions/short', as: :short_question
  post 'questions/submit', to: 'questions#submit_question', as: :submit_question
  post 'questions/export', to: 'questions#build_csv', defaults: { format: 'csv' }
  post 'questions/import', to: 'questions#import_csv', as: :upload_questions
end
