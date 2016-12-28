# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

api_create_progress = (elem,sdata) ->
  console.log("Writing info")
  id = "server-#{sdata.name}"
  if sdata.online
    elem.append $("<div class='text-xs-center' id='#{id}'></div>").text("#{sdata.name} #{sdata.players}/#{sdata.max}")
    elem.append $("<progress class='progress' value='#{sdata.players.replace(/[^0-9]/g,'')}' max='#{sdata.max.replace(/[^0-9]/g,'')}' aria-describedby='#{id}' />")
  else
    elem.append $("<div class='text-xs-center' id='#{id}'></div>").text("#{sdata.name} offline")
    elem.append $("<progress class='progress server-full' value='1' max='1' aria-describedby='#{id}' />")

api_write_error = (elem,json) ->
  console.log "Writing error"
  elem.append($("<div class='alert'>#{json.error}</div>"))

api_write_info = (elem,short_name) ->
  $.ajax
    dataType: "json"
    url: "/api/server?name=#{short_name}"
    success: (json) ->
      console.log json
      if json.error?
        api_write_error elem,json
      else
        api_create_progress elem,json
    error: (j)->
      console.log j
      api_write_error elem,
        error: "Cannot retrieve data"

window.onload = () ->
  console.log "Loading"
  mondiv = $("#tsmon")
  if mondiv.length
    console.log("Monitoring enabled")
    $.ajax
      url: "/api/servers"
      dataType: "json"
      success: (json) ->
        console.log json
        mondiv.empty()
        mondiv.append($("<h3>Мониторинг</h3>"))
        mondiv.append("<!-- Generated in app/assets/javascripts/home.coffee -->")
        if json.servers? && json.servers.length > 0
          for serv in json.servers
            console.log serv
            api_write_info mondiv, serv.shortName
        else
          mondiv.append($("<div class='text-muted'></div>").text("Не найдены сервера"))
      error: (json) ->
        console.log json
  else
    console.log("Monitoring disabled")

  graph = $("#tsgraph")
  if graph.length
    console.log("Graph enabled")
    $.ajax
      url: "/api/graph"
      dataType: "json"
      success: (json) ->
        console.log json
        new Chart graph,
          type: 'line'
          data: json
      error: (json) ->
        console.error json
  else
    console.log("Graph disabled")
