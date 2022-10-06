Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :dashboard
  end
  root "home#index"
  resources :transport_modes, only: [:index, :show, :new, :create, :edit, :update] do
    patch :activate, on: :member
    patch :deactivate, on: :member
  end
  resources :vehicles, only: [:index, :show, :new, :create, :edit, :update] do
    get 'search', on: :collection
    patch :activate, on: :member
    patch :deactivate, on: :member
  end
  resources :deadlines, only: [:new, :create, :edit, :update]
  resources :weight_tables, only: [:new, :create, :edit, :update]
  resources :distance_tables, only: [:new, :create, :edit, :update]
  resources :orders, only: [:index, :show, :new, :create, :edit, :update] do
    get 'search', on: :collection
    patch :set_pending, on: :member
    patch :set_canceled, on: :member
    patch :set_delivered, on: :member
  end
end
