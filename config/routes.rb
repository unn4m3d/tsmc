Rails.application.routes.draw do
  # Posts
  get 'posts/index'

  get 'posts/new'
  post 'posts/new', to: 'posts#create'

  get 'posts/view/:id', to: 'posts#view', as: 'post'

  get 'posts/update/:id', to: 'posts#update', as: 'post_update'
  post 'posts/update/:id', to: 'posts#commit'
  post 'posts/view/:id', to: 'posts#commit'

  get 'posts/delete'

  # Yggdrasil methods
  get 'api/join'
  post 'api/join'
  get 'api/has_joined'
  post 'api/has_joined'

  # API
  get 'api/auth'
  get 'api/servers'
  get 'api/server'
  get 'api/launcher'
  get 'api/files'
  get 'api/assets'
  devise_for :users
  get 'home/index'

  get 'home/about'

  get 'home/index'
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
