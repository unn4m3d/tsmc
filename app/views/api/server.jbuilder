json.name @server.name
json.shortName @server.short_name
json.version @server.version
json.ip @server.ip
json.port @server.port
json.link servers_show_path(id: @server.id)
json.online @server_data.online
if @server_data.online
  json.motd @server_data.motd
  json.players @server_data.current_players
  json.max @server_data.max_players
end
