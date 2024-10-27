Rails.application.routes.draw do
  devise_for :users
  post 'tweets/:tweet_id/react/:reaction_level_id', to: 'tweets#react', as: 'tweet_react'
  root "static_pages#home"
  resources :tweets, except: [:update, :edit] do
    resources :comments, only: [:create, :new, :destroy, :index, :show]
  end
  get 'hashtags/:name', to: 'hashtags#show', as: :hashtag
  get 'search', to: 'hashtags#search', as: :search_hashtag
  resources :users, only: [:show]
end
