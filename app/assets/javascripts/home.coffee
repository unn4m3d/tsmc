# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

api_create_progress = (elem,sdata) ->
  if sdata.online
    id = "server-#{sdata.short_name}"
    elem.append($("<div class='text-xs-center' id='#{id}'></div>").text("#{sdata.name} #{sdata.players}/#{sdata.max}")
    elem.append($(
      "<progress class='progress' value='#{sdata.players}' max='#{sdata.max}' aria-describedby='#{id}' />"
    ))
  else
    id = "server-#{sdata.short_name}"
    elem.append($("<div class='text-xs-center' id='#{id}'></div>").text("#{sdata.name} offline")
    elem.append($(
      "<progress class='progress server-full' value='1' max='1' aria-describedby='#{id}' />"
    ))
