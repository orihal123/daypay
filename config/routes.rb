Rails.application.routes.draw do
  root to: 'welcomes#index'

  resources :welcomes, only: [:index]
  resources :reports, only: [:index, :new]
  resources :incomes, only: [:new, :create]
  resources :expenses, only: [:new, :create]
  resources :expense_days, only: [:new, :create]
  resources :budgets, only: [:new, :create]
  resources :calendars, only: [:index]
  

end