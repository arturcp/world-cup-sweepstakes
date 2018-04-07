Rails.application.routes.draw do
  devise_for :users
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :games, only: :index, scope: :tournament

  resources :tournament, only: :index, param: :tournament_name do
    get :games, on: :member, to: 'games#index'
    post :user_guesses, on: :member, to: 'user_guesses#create'
  end

  root to: 'home#index'
end
