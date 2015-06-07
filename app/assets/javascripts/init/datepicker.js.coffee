ready = ->
  $('input.datepicker').datepicker
    language: 'es'
    format: 'yyyy-mm-dd'
    autoclose: true

$(document).on 'ready page:load', ready
