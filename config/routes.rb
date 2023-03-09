Rails.application.routes.draw do
  root to: 'users#index'
  devise_for :users, controllers: { confirmations: 'confirmations' } 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [:index, :show, :create] do
    resources :posts, only: [:new, :show, :index, :create] do
      resources :comments, only: [:new, :create]
      member do
        put "like", to: "posts#like"
        delete "unlike", to: "likes#destroy"
      end
    end
  end

  resources :posts, only: [] do
    member do
      get "like", to: "posts#like", as: :like_post
      get "unlike", to: "posts#unlike", as: :unlike_post
    end
  end
end