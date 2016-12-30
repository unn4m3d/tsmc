# rubocop:disable ClassLength
# rubocop:disable MethodLength
# rubocop:disable AbcSize
# API Controller
class ApiController < ApplicationController
  include UuidHelper
  include ApiHelper
  include XorHelper

  skip_before_action :verify_authenticity_token

  private def public_path(*x)
    puts x.inspect
    x.inject(Rails.root) { |a, e| a.join(e) }.to_s
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
      render text: public_path(Settings.launcher_path.generic)
    else
      render text: public_path(Settings.launcher_path[platform.to_sym])
    end
  end

  # Yggdrasil method
  def join
    data = JSON.parse request.raw_post

    uuid = data['selectedProfile']
    sid = data['accessToken']
    server = data['serverId']

    sessions = Session.where(uuid: uuid, session: sid)

    if [uuid.to_s, sid.to_s, server.to_s, sessions].any?(&:empty?)
      render json: { error: 'Bad login', errorMessage: 'Bad login' }
      return
    else
      session = sessions.first
      session.serverid = server
      session.save!
      render json: { id: uuid, name: session.user.username }
    end
  end

  # rubocop:disable PredicateName
  # Yggdrasil method
  def has_joined
    @username = params[:username]
    server = params[:serverId]

    sessions = Session.joins(:user).where(
      serverid: server,
      users: { username: @username }
    )
    if sessions.empty?
      render json: { error: 'Bad login', errorMessage: 'Bad login' }
      return
    else
      user = sessions.first.user
      @uuid = sessions.first.uuid
      @textures = gen_texdata(@uuid, user.username, user)
    end
  end
  # rubocop:enable PredicateName

  def auth
    version = params[:version]
    begin
      @session = Session.find(params[:sid].to_i)
    rescue ActiveRecord::RecordNotFound
      @error = 'Wrong SID'
      @error_type = :session
      render :error
      return
    end
    lv = Settings.launcher_version
    dv = decrypt(version, @session.key).split('$').first
    if dv != lv
      puts dv, lv
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

    pass = decrypt params[:password], @session.key
    if user.first.valid_password?(pass)
      @username = params[:username]
      @access_token = username_to_uuid @username
      @session_id = gen_sid(@access_token)

      Session.where(user_id: user.first.id).delete_all

      @session.user = user.first
      @session.session = @session_id
      @session.uuid = @access_token.delete('-')
      @session.save!

      puts "UUID : #{@access_token}"

      @session_id = @session_id

    else
      puts params[:password]
      puts pass
      @error = 'Bad password'
      @error_type = :login
      render :error
    end
  end

  # rubocop:disable CyclomaticComplexity
  def files
    client = params[:client]
    unless client
      @error = 'No client specified'
      @error_type = :client
      render :error
      return
    end

    all = params[:all]
    @dir = public_path(Settings.clients_path, client)
    unless File.exist? @dir
      @error = 'Wrong client short_name'
      @error_type = :client
      render :error
      return
    end

    @files = []
    @ignore = Settings.ignore_regex.to_s

    Dir.chdir(@dir.to_s) do
      Dir.glob('**/*') do |e|
        regex = @ignore
        ig = File.expand_path(e).match(Regexp.new(regex))
        if !File.directory?(e) && (all || regex.empty? || !ig)
          @files << file_info(@dir.to_s, File.expand_path(e))
        end
      end
    end
    @dir.gsub!(Rails.root.join('public').to_s, '')
  end
  # rubocop:enable CyclomaticComplexity

  # rubocop:disable AccessorMethodName
  def get_session
    session = Session.create(key: Random.rand(0xFFFFFFFF).to_s)
    render json: { id: session.id, key: session.key }
  end
  # rubocop:enable AccessorMethodName

  def assets
    @dir = public_path(Settings.clients_path, 'assets')
    puts @dir
    unless File.exist? @dir
      @error = 'Assets do not exist'
      @error_type = :client
      render :error
      return
    end

    @files = []

    Dir.chdir(@dir.to_s) do
      Dir.glob('**/*') do |e|
        @files << ('/' + e) unless File.directory?(e)
      end
    end
    @dir.gsub!(Rails.root.join('public').to_s, '')
  end

  def servers
    @servers = Server.all
  end

  def news
    @posts = Post.last(5)
    render :news, layout: false
  end

  def graph
    @stats = if params[:servers]
               ServerStat.where(server_id: params[:servers])
             else
               ServerStat.all
             end
    pstats, slabels = pretty_stats @stats.select { |x| x.time >= 24.hours.ago }
    @labels = pstats.keys
    @datasets = slabels.map do |label|
      {
        label: label,
        data: @labels.map { |time| pstats[time][label].players || 0 },
        backgroundColor: COLORS[Digest::MD5.hexdigest(label)[-2..-1].to_i(16) % COLORS.size][:bg],
        borderColor: COLORS[Digest::MD5.hexdigest(label)[-2..-1].to_i(16) % COLORS.size][:border]
      }
    end
  end

  # Yggdrasil method
  def profile
    @uuid = params[:uuid]
    sessions = Session.where(uuid: @uuid)
    if sessions.empty?
      render status: :no_content
      return
    end
    @username = sessions.first.user.username
    @textures = gen_texdata @uuid, @username, sessions.first.user
  end
end
