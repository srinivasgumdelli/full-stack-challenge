Rails.application.routes.draw do
  root to: 'resource_sites#index'

  resources :resource_sites
end
