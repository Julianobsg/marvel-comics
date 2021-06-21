Rails.application.routes.draw do
  root to: 'home#index'
  resources :comics, only: :index do
    post :favorite
  end
end
