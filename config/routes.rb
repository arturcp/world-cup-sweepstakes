Rails.application.routes.draw do
  devise_for :users
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :games, only: :index, scope: :tournament

  resources :tournament, only: :index, param: :tournament_name do
    get :games, on: :member, to: 'games#index'
    put :games, on: :member, to: 'games#update'
    post :user_guesses, on: :member, to: 'user_guesses#create'
    put :user_guesses, on: :member, to: 'user_guesses#update'
    post :ranking, on: :member, to: 'ranking#create'
    get :ranking, on: :member, to: 'ranking#index'
    get 'ranking/:user_id', on: :member, to: 'ranking#show', as: :ranking_log
  end


  root to: 'home#index'
end
