Rails.application.routes.draw do
  get 'help/index'

  get 'help/commandbook'

  get 'help/worldguard'

  get 'help/craftbook'

  get 'help/faq'

  get 'help/economy'

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
  get 'api/profile/:uuid/', to: 'api#profile'
  post 'api/profile/:uuid/', to: 'api#profile'

  # API
  get 'api/auth'
  get 'api/servers'
  get 'api/server'
  get 'api/launcher'
  get 'api/files'
  get 'api/assets'
  get 'api/session', to: 'api#get_session'
  get 'api/news'
  get 'api/graph'
  devise_for :users
  get 'home/index'

  get 'home/about'

  get 'home/launcher'

  get 'home/pretty_skin/:id', to: 'home#pretty_skin', as: 'pretty_skin'
  get 'home/pretty_cape/:id', to: 'home#pretty_cape', as: 'pretty_cape'
  get 'home/minecraft_settings'
  post 'home/update_skin', as: 'update_skin'
  post 'home/update_cape', as: 'update_cape'
  post 'home/update_avatar', as: 'update_avatar'

  root to: 'home#index'
end
