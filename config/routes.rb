Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :dashboard
  end
  root "home#index"
end
