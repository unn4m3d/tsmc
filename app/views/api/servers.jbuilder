json.servers @servers do |serv|
  json.name serv.name
  json.short_name serv.short_name
  json.version serv.version
  json.ip serv.ip
  json.port serv.port
end
