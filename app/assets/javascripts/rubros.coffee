# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  convertMarkdown()
  $('textarea#rubro_descripcion').change ->
    convertMarkdown()

convertMarkdown = ->
  text = $('textarea#rubro_descripcion').val()
  converter = new showdown.Converter()
  $('div#descripcion-html').html converter.makeHtml(text)

$(document).on 'ready page:load', ready
