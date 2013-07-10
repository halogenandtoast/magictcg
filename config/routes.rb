require 'signed_in_constraint'

Tcg::Application.routes.draw do
  constraints SignedInConstraint.new do
    get "/" => "dashboards#show"
  end

  root to: "homes#show"
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resource :dashboard, only: [:show]
  resources :collected_cards, only: [:show]
  resources :collecting_sets, only: [:index, :create, :show, :destroy]
  resources :card_versions, only: :none do
    resources :collected_cards, only: [:create, :destroy]
  end
end
