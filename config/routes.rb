ShindigSheriff::Application.routes.draw do

  devise_for :users

  resources :users do  
    resources :organizations
  end

  resources :organizations, only: [] do
    resources :events, only: [:index, :new, :create]
    resources :finance_approvers, only: [:new, :create]
  end

  resources :events, only: [] do
    resources :incomes, only: [:index, :new, :create]
  end

  root to: 'users#new'

end

