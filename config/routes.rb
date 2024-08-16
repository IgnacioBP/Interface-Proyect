Rails.application.routes.draw do
  resources :comments
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_pages#home"
  resources :tweets, except: [:update, :edit]
end
