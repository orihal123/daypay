Rails.application.routes.draw do
  root to: 'reports#index'
  
  resources :reports, only: [:index, :new]
  resources :incomes, only: [:new, :create]
end