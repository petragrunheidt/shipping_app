Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :dashboard
  end
  root "home#index"
  resources :transport_modes, only: [:index, :show, :new, :create, :edit, :update]
end
