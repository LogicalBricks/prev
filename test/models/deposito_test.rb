require 'test_helper'

class DepositoTest < ActiveSupport::TestCase
  should belong_to :prevision
  should have_many :gastos
  should validate_presence_of :fecha
  should validate_presence_of :prevision
  should validate_presence_of :monto
  should validate_numericality_of(:monto).is_greater_than(0)

  test "does not allow to set a fecha before the prevision's innitial date" do
    prevision = FactoryGirl.create :prevision, periodo: Date.today.year
    deposito = FactoryGirl.build :deposito, fecha: 1.year.ago, prevision: prevision
    refute deposito.valid?
    assert_equal 1, deposito.errors[:fecha].size
  end

  test "does not allow to set a fecha after the prevision's final date" do
    prevision = FactoryGirl.create :prevision, periodo: Date.today.year
    deposito = FactoryGirl.build :deposito, fecha: 1.year.from_now, prevision: prevision
    refute deposito.valid?
    assert_equal 1, deposito.errors[:fecha].size
  end

  test "does not allow to set a monto greater than the prevision's monto" do
    prevision = FactoryGirl.create :prevision, monto_remanente: 1, monto_presupuestado: 99
    deposito = FactoryGirl.build :deposito, monto: 101, prevision: prevision
    refute deposito.valid?
    assert_equal 1, deposito.errors[:monto].size
  end

  test "does not allow to set a monto that exceeds prevision's monto" do
    prevision = FactoryGirl.create :prevision, monto_remanente: 1, monto_presupuestado: 99
    FactoryGirl.create :deposito, monto: 99, prevision: prevision
    deposito = FactoryGirl.build :deposito, monto: 2, prevision: prevision
    refute deposito.valid?
    assert_equal 1, deposito.errors[:monto].size
  end

  test "should allow update monto if this does not exceed prevision's monto" do
    prevision = FactoryGirl.create :prevision, monto_remanente: 1, monto_presupuestado: 99
    deposito = FactoryGirl.create :deposito, monto: 99, prevision: prevision
    deposito.update monto: 2
    refute deposito.errors[:monto].include?("rebasa el monto total de la previsión")
  end

  test "should validate absence of gasto when pago_de_comisiones_o_impuestos is false" do
    prevision = FactoryGirl.create :prevision, monto_remanente: 1, monto_presupuestado: 99
    deposito = FactoryGirl.create :deposito, monto: 95, prevision: prevision
    gasto = FactoryGirl.create :gasto, apartado: FactoryGirl.create(:apartado, prevision: prevision), monto: 10
    deposito = FactoryGirl.build :deposito, monto: 1.6, prevision: prevision, gasto_ids: [gasto.id], pago_de_comisiones_o_impuestos: false
    refute deposito.valid?
    assert_equal 1, deposito.errors[:gastos].size
  end

  test "should accept gasto when pago_de_comisiones_o_impuestos is true" do
    prevision = FactoryGirl.create :prevision, monto_remanente: 1, monto_presupuestado: 99
    deposito = FactoryGirl.create :deposito, monto: 95, prevision: prevision
    gasto = FactoryGirl.create :gasto, apartado: FactoryGirl.create(:apartado, prevision: prevision), monto: 10
    deposito = FactoryGirl.build :deposito, monto: 1.6, prevision: prevision, gasto_ids: [gasto.id], pago_de_comisiones_o_impuestos: true
    assert deposito.valid?
  end
end

# == Schema Information
#
# Table name: depositos
#
#  id           :integer          not null, primary key
#  monto        :decimal(, )
#  fecha        :date
#  descripcion  :text
#  prevision_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
