# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $div = $("#pago-comision-o-impuestos")
  $checkbox = $("#deposito_pago_de_comisiones_o_impuestos")
  $div.toggle($checkbox.is(":checked"))
  $checkbox.on 'change', -> $div.toggle($(this).is(":checked"))

$(document).on 'ready page:load', ready
