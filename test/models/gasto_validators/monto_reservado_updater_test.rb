require 'test_helper'

module GastoValidators
  class MontoReservadoUpdaterTest < ActiveSupport::TestCase
    test "should update tope's monto_reservado with 10" do
      gasto = Gasto.new monto: 10
      tope = Minitest::Mock.new
      tope.expect :monto_reservado, 15
      tope.expect :update, true, [{ monto_reservado: 5 }]
      MontoReservadoUpdater.new(gasto, tope).call
      tope.verify
    end

    test "should update tope's monto_reservado with 11" do
      gasto = Gasto.new monto: 11
      tope = Minitest::Mock.new
      tope.expect :monto_reservado, 15
      tope.expect :update, true, [{ monto_reservado: 4 }]
      MontoReservadoUpdater.new(gasto, tope).call
      tope.verify
    end
  end
end
