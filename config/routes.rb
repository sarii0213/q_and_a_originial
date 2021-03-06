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
    resources :answers, only: %i[create destroy]
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  namespace :admin do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    resources :questions, only: %i[index destroy]
    resources :users, only: %i[index destroy]
  end
end
