Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  root to: "dashboards#index"
  resources :users do
    resources :exercises
  end
end
