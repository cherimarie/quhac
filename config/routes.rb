Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :providers

  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  post "/submit_contact", to: "static_pages#submit_contact"
  get "search", to: "searches#new"

  root "providers#index"
end
