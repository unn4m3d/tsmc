class ServersController < ApplicationController
  def index
  end

  def show
    @server = Server.find params[:id]
    if @server.nil?
      redirect_to not_found_path
      return
    end
  end

  def export
    @servers = Server.all
    @mods = Mod.all.order(:title)
  end
end
