Rails.application.routes.draw do
  get 'reports/index'
  
  resources :reports, only: [:new]
end