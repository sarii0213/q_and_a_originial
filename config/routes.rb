Rails.application.routes.draw do

  resources :users, only: %i[index new create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :questions do
    collection do
      get 'unsolved'
      get 'solved'
    end
    member do
      post 'solve'
    end
  end

end
