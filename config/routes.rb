Rails.application.routes.draw do
  # devise_for :admins
  root to: 'resource_sites#index'
  devise_for :users

  authenticate :user do
    resources :resource_sites, only: [:new, :create, :edit, :update, :destroy]
    scope "/admin" do
      resources :eligibilities
    end
  end
  resources :resource_sites, only: [:index, :show]
end
