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

  def profile
    id = params[:id]

    if id.nil? || id.to_s.empty?
      if user_signed_in?
        @user = current_user
      else
        redirect_to new_user_session_path
        return
      end
    elsif id.to_s.match /^[0-9]+$/
      @user = User.find id.to_i
    else
      @user = User.where(username: id).first
    end

    if @user.nil?
      redirect_to not_found_path
      return
    end

    @skin_url = @user.skin_url
    @cape_url = @user.cape_url
    @pretty_skin_url = pretty_skin_path(@user)
    @pretty_cape_url = pretty_cape_path(@user)
    @has_cape = !@cape_url.empty?
    @avatar_url = @user.avatar_url
    @has_avatar = !@avatar_url.empty? && !@avatar_url.nil?
  end

  def not_found
  end

  def update_skin
    user = User.find(params[:id])
    authorize! :manage, user
    user.skin = params[:skin][:skin]
    user.save!
    redirect_to home_profile_path
  end

  def update_avatar
    user = User.find(params[:id])
    authorize! :manage, user
    user.avatar = params[:avatar][:avatar]
    user.save!
    redirect_to home_profile_path
  end

  def pretty_skin
    user = User.find(params[:id])
    puts 'Starting...'
    path = user.skin.blank? ? "public/default_skin.png" : user.skin.path
    data = prettify_skin(path, 320)
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
    user = User.find(params[:id])
    authorize! :manage, user
    user.cape = params[:cape][:cape]
    user.save!
    redirect_to home_profile_path
  end

  def add_role
    authorize! :assign, :roles
    u = User.find(params[:user][:id])
    roles = u.roles
    roles << params[:user][:role]
    u.role = roles.join(';')
    u.save!
    redirect_to home_profile_path
  end

  def delete_role
    authorize! :assign, :roles
    u = User.find(params[:user][:id])
    roles = u.roles
    roles.delete(params[:user][:role])
    u.role = roles.join(';')
    u.save!
    redirect_to home_profile_path
  end
end
