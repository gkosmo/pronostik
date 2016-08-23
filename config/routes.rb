Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :questions, only: [:index, :show] do
    resources :bets, only: [:new, :create, :update]
  end

  namespace :dashboard do

    resources :meetings, only: [] do
      member do
      end
    end
  end
end
