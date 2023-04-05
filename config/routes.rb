Rails.application.routes.draw do
  resources :users do
    member do
      get :expand
      get :collapse
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
end
