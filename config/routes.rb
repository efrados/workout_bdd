Rails.application.routes.draw do
  devise_for :users
  root to: "dashboards#index"
  resources :users do
    resources :exercises
  end
end
