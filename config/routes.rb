Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :providers

  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/advanced_search", to: "static_pages#advanced_search"
  post "/submit_contact", to: "static_pages#submit_contact"

  root "static_pages#about"
end
