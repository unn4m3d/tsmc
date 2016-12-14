# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

api_create_progress = (elem,sdata) ->
  if sdata.online
    id = "server-#{sdata.short_name}"
    elem.append $("<div class='text-xs-center' id='#{id}'></div>").text("#{sdata.name} #{sdata.players}/#{sdata.max}")
    elem.append $("<progress class='progress' value='#{sdata.players}' max='#{sdata.max}' aria-describedby='#{id}' />")
  else
    id = "server-#{sdata.short_name}"
    elem.append $("<div class='text-xs-center' id='#{id}'></div>").text("#{sdata.name} offline")
    elem.append $("<progress class='progress server-full' value='1' max='1' aria-describedby='#{id}' />")

api_write_error = (elem,json) ->
  elem.append($("<div class='alert'>#{json.error}</div>"))

api_write_info = (elem,short_name) ->
  $.ajax
    dataType: "json"
    url: "/api/server"
    data:
      name: short_name
    success: (json) ->
      if json.error?
        api_write_error elem,json
      else
        api_create_progress elem,json
    error: ()->
      api_write_error elem,
        error: "Cannot retrieve data"

window.onload = () ->
  mondiv = $("#tsmon")
  if mondiv.length
    $.ajax
      url: "/api/servers"
      dataType: "json"
      success: (json) ->
        mondiv.clear()
        mondiv.append($("<h3>Мониторинг</h3>"))
        if json.servers? && json.servers.length > 0
          for serv of json.servers
            api_write_info mondiv, serv.short_name
        else
          mondiv.append($("<div class='text-muted'></div>").text("Не найдены сервера"))
