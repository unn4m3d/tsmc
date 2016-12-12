class ApiController < ApplicationController
  include UuidHelper
  include ApiHelper

  def server

  end

  def launcher

  end

  # Yggdrasil method
  def join
  end

  # Yggdrasil method
  def has_joined
  end

  def auth

  end

  def files
    client = params[:client]
    if !client
      @error = "No client specified"
      render :error
      return
    end

    all = params[:all]
    dir = Rails.root.join("assets").join(Settings.clients_path).join(client)
    unless dir.exist?
      @error = "Wrong client short_name"
      render :error
      return
    end

    @files = []

    Dir.chdir(dir.to_s) do
      Dir.glob("**") do |elem|
        if !elem.directory? && (all || Settings.ignore_regex.empty? || !File.expand_path(elem.path).match(Regex.new(Settings.ignore_regex))) 
          @files << file_info(dir.to_s,File.expand_path(elem))
        end
      end
    end
  end

  def servers
    @servers = Server.all
  end
end
