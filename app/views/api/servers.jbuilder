json.servers @servers do |serv|
  json.name serv.name
  json.shortName serv.short_name
  json.version serv.version
  json.ip serv.ip
  json.port serv.port
  json.link servers_show_path(id: serv.id)
end
