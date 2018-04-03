Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :games, only: :index, scope: :tournament

  resources :tournament, only: :index, param: :tournament_name do
    get :games, on: :member, to: 'games#index'
  end

  root to: 'home#index'
end
