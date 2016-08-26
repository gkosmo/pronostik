Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  root to: 'questions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'faq', to: 'pages#faq'
  resources :questions, only: [:index, :show] do
    patch 'makepending', to: 'questions#make_pending'
    resources :bets, only: [:new, :create, :update] do
      resources :just_upvotes, only: [:new, :create]
    end
  end

  namespace :dashboard do
      resources :statistics
      resources :questions
      resources :bets
      get 'history', to: 'histories#index'
    end

end
