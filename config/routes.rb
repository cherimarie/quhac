Rails.application.routes.draw do
  resources :providers
  root "providers#index"
end
