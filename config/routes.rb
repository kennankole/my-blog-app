Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  get '/users/:user_id/posts(.:format)', to: 'posts#index'
  get  '/users/:user_id/posts(.:format)', to:  'posts#index'
  get  '/users/:user_id/posts/:id(.:format)', to: 'posts#show'
  get  '/users(.:format)', to: 'users#index'
  get  '/users/:id(.:format)', to: 'users#show'

  # resources :users do
  #   resources :posts, only: [:index], controller: 'posts'
  # end
end