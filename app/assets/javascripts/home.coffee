# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  calendar_month()

calendar_month = ->
  $('#mes').datepicker({
    format: 'MM',
    minViewMode: 'months',
    language: 'es'
    autoclose: true
  })

$(document).on 'turbolinks:load', ready
