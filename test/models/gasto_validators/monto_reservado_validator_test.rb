require 'test_helper'

module GastoValidators
  class MontoReservadoValidatorTest < ActiveSupport::TestCase
    test "should be valid when socio's monto_reservado is fewer than gasto's monto" do
      gasto = Struct.new(:monto, :socio_monto_reservado).new(10, 11)
      assert MontoReservadoValidator.new(gasto).valid?, "Es inválido cuando el monto es menor al reservado."
    end

    test "should be valid when socio's monto_reservado is equals to gasto's monto" do
      gasto = Struct.new(:monto, :socio_monto_reservado).new(10, 10)
      assert MontoReservadoValidator.new(gasto).valid?, "Es inválido cuando el monto es menor al reservado."
    end

    test "should not be valid when socio's monto_reservado is greater than gasto's monto" do
      gasto = Struct.new(:monto, :socio_monto_reservado).new(11, 10)
      refute MontoReservadoValidator.new(gasto).valid?, "Es válido cuando el monto es mayor al reservado."
    end
  end
end
