Rails.application.routes.draw do
  get 'api/join'
  post 'api/join'
  get 'api/has_joined'
  post 'api/has_joined'
  get 'api/auth'
  get 'api/servers'
  get 'api/server'
  get 'api/launcher'
  get 'api/files'
  devise_for :users
  get 'home/index'

  get 'home/about'

  get 'home/index'
  root to:"home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
