class ApiController < ApplicationController
  include UuidHelper
  include ApiHelper

  private def asset_path(*x)
    ActionController::Base.helpers.asset_path(*x)
  end

  def server
    name = params[:name]
    servers = Server.where(short_name: name)
    if servers.empty?
      @error = "Server #{name} not found"
      @error_type = :server
      render :error
      return
    end

    @server = servers.first
    @server_data = server_data @server
  end

  def launcher
    platform = params[:platform]
    if platform.nil? || Settings.launcher_path[platform.to_sym].nil?
      render text: asset_path(Settings.launcher_path.generic)
    else
      render text: asset_path(Settings.launcher_path[platform.to_sym])
    end
  end

  # Yggdrasil method
  def join
    data = JSON.parse raw_post

    uuid = data['selectedProfile']
    sid = data['accessToken']
    server = data['serverId']

    sessions = Session.where(uuid: uuid, session: sid)

    if [uuid.to_s, sid.to_s, server.to_s, sessions].any?(&:empty?)
      render json: { error: 'Bad login', errorMessage: 'Bad login' }
      return
    else
      session = sessions.first
      session.server = server
      session.save!
      render json: { id: uuid, name: session.user.username }
    end
  end

  # Yggdrasil method
  def has_joined
    @username = params[:username]
    server = params[:serverId]

    sessions = Session.joins(:user).where(
      server: server,
      users: { username: username }
    )
    if sessions.empty?
      render json:{ error: 'Bad server id or login', errorMessage: 'Bad login'}
      return
    else
      user = sessions.first.user
      @uuid = sessions.first.uuid
      @textures = {
        timestamp: Time.now.to_i,
        profileId: @uuid,
        profileName: username,
        isPublic: true,
        textures: {
          SKIN: {
            url: user.skin_url || asset_path(Settings.skins.default)
          }
        }
      }

      unless user.cape_url.to_s.empty?
        @textures[:textures][:CAPE] = { url: user.cape_url.to_s }
      end
    end
  end

  def auth
    version = params[:version]
    if Settings.launcher_version != version
      @error = 'Wrong launcher version'
      @error_type = :launcher
      render :error
      return
    end

    user = User.where(username: params[:username])
    if user.empty?
      @error = 'Bad username'
      @error_type = :login
      render :error
      return
    end

    if user.first.valid_password?(params[:password])
      @username = params[:username]
      @access_token = username_to_uuid @username
      @session_id = gen_sid(@access_token)
      begin
        session = Session.find(user.first.id)
        session.session = @session_id
        session.uuid = @access_token
        session.save!
      rescue ActiveRecord::RecordNotFound
        Session.create(
          user_id: user.first.id,
          session: @session_id,
          uuid: @access_token
        )
      end
    else
      @error = 'Bad password'
      @error_type = :login
      render :error
    end
  end

  def files
    client = params[:client]
    unless client
      @error = 'No client specified'
      @error_type = :client
      render :error
      return
    end

    all = params[:all]
    dir = Rails.root.join('assets').join(Settings.clients_path).join(client)
    unless dir.exist?
      @error = 'Wrong client short_name'
      @error_type = :client
      render :error
      return
    end

    @files = []

    Dir.chdir(dir.to_s) do
      Dir.glob('**') do |elem|
        ig = File.expand_path(elem.path).match(Regex.new(Settings.ignore_regex))
        if !elem.directory? && (all || Settings.ignore_regex.empty? || !ig)
          @files << file_info(dir.to_s, File.expand_path(elem))
        end
      end
    end
  end

  def servers
    @servers = Server.all
  end
end
