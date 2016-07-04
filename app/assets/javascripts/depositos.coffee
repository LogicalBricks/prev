# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

toggleComisionesImpuestoSection = ->
  $div = $("#pago-comision-o-impuestos")
  $checkbox = $("#deposito_pago_de_comisiones_o_impuestos")
  $div.toggle($checkbox.is(":checked"))
  $checkbox.on 'change', -> $div.toggle($(this).is(":checked"))

calculateDepositoMontoFromComisionesImpuestos = ->
  $selects = $('#deposito_gasto_ids, #deposito_comision_ids')
  $selects.on 'change', (e) ->
    monto = 0
    $selects.find("option:selected").each (a) ->
      v = parseFloat($(this).data('monto'))
      monto += v unless isNaN(v)
    $("#deposito_monto").val(monto)

ready = ->
  toggleComisionesImpuestoSection()
  calculateDepositoMontoFromComisionesImpuestos()

$(document).on 'ready turbolinks:load', ready
