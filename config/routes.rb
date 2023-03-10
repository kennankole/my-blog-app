Rails.application.routes.draw do
  root to: 'users#index'
  devise_for :users, controllers: { confirmations: 'confirmations' } 

  resources :users, only: [:index, :show, :create] do
    resources :posts, only: [:new, :show, :index, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      member do
        put "like", to: "posts#like"
        delete "unlike", to: "likes#destroy"
      end
    end
  end

  resources :posts, only: [:new, :show, :index, :create, :destroy] do
    member do
      get "like", to: "posts#like", as: :like_post
      get "unlike", to: "posts#unlike", as: :unlike_post
    end
  end
  delete "posts/:id/remove", to: "posts#destroy", as: "remove_post"
  delete "users/:id/posts/:id/comments/:id/remove", to: "comments#destroy", as: "remove_comment"

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index] do
        resources :posts, only: [:index, :show] do
          resources :comments, only: [:index, :create]
        end
        resources :comments, only: [:index]
      end
    end
  end
end