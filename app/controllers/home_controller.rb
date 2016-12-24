# Home controller
class HomeController < ApplicationController
  include HomeHelper
  def index
    @posts = Post.last(3)
  end

  def about
  end

  def launcher
  end

  def minecraft_settings
    unless user_signed_in?
      redirect_to new_user_session_path
      return
    end
    @skin_url = current_user.skin_url
    @cape_url = current_user.cape_url
    @pretty_skin_url = pretty_skin_path(current_user)
    @pretty_cape_url = pretty_cape_path(current_user)
    @has_cape = !@cape_url.empty?
  end

  def update_skin
    current_user.skin = params[:skin][:skin]
    current_user.save!
    redirect_to home_minecraft_settings_path
  end

  def pretty_skin
    user = User.find(params[:id])
    puts 'Starting...'
    data = prettify_skin(user.skin.path, 320)
    if data
      send_data(
        data,
        content_type: 'image/png',
        disposition: 'inline',
        filename: "#{user.username}.png"
      )
    else
      render status: :not_found
    end
  end

  def pretty_cape
    user = User.find(params[:id])
    puts 'Starting...'
    data = prettify_cape(user.cape.path, 320)
    if data
      send_data(
        data,
        content_type: 'image/png',
        disposition: 'inline',
        filename: "#{user.username}.png"
      )
    else
      render status: :not_found
    end
  end

  def update_cape
    current_user.cape = params[:cape][:cape]
    current_user.save!
    redirect_to home_minecraft_settings_path
  end
end
