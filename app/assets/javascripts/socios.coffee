# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $("#link-detalles-monto-gastado a").click ->
    $("#detalles-monto-gastado").toggle()
    $(this).text (i, text) -> if text == "[+]" then "[-]" else "[+]"
    false

$(document).on 'ready turbolinks:load', ready
