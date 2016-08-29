Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  root to: 'questions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'faq', to: 'pages#faq'
  get 'questions/new_index'
  get 'questions/good_index'
  resources :questions, only: [:index, :show] do
    patch 'makepending', to: 'questions#make_pending'
    resources :bets, only: [:new, :create, :update] do
      resources :just_upvotes, only: [:new, :create]
    end
  end
  resources :bets, only: [:index]

  namespace :dashboard do
      get 'dashboard' => 'dashboard#statistics'
      resources :statistics
      resources :questions
      resources :bets
      resources :notifications
      get 'history', to: 'histories#index'
    end

end
