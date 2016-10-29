# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  date_periodo()

date_periodo = ->
  $('#prevision_periodo').datepicker({
    format: 'yyyy',
    minViewMode: "years"
  })

$(document).on 'turbolinks:load', ready
