Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :providers
  get "search", to: "searches#new"
  root "providers#index"
end
