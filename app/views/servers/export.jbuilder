json.servers @servers do |server|
    json.name server.name
    json.short_name server.short_name
    json.version server.version
    json.ip server.ip
    json.port server.port
    json.mods server.mods.map(&:title)
end

json.mods @mods do |mod|
    json.title mod.title
    json.wiki mod.wiki  
end