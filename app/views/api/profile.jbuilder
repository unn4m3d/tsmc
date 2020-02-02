json.id @uuid
json.name @username
json.properties [
  {
    name: "textures",
    signature: "Cg==",
    value: Base64.strict_encode64(JSON.generate(@textures))
  }
]
