Rails.application.routes.draw do
  root to: 'home#index'
  resources :comics, only: :index
end
