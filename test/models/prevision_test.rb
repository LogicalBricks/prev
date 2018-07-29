require 'test_helper'

class PrevisionTest < ActiveSupport::TestCase
  should have_many(:depositos)
  should have_many(:apartados)
  should have_many(:topes)
  should have_many(:comisiones)
  should validate_presence_of(:monto_presupuestado)
  should validate_numericality_of(:monto_presupuestado).is_greater_than(0)
  should accept_nested_attributes_for(:apartados).allow_destroy(true)
  should accept_nested_attributes_for(:topes).allow_destroy(true)

  test '#to_s is the periodo' do
    prevision = FactoryGirl.build(:prevision, periodo: 2014)
    assert_equal "2014", prevision.to_s
  end

  test "should generate date ranges" do
    prevision = FactoryGirl.build(:prevision, periodo: 2014)
    prevision.valid?
    assert_equal "2014/01/01".to_date, prevision.fecha_inicial
    assert_equal "2014/12/31".to_date, prevision.fecha_final
  end

  test '#monto_depositado is the sum of depositos for gastos' do
    prevision = FactoryGirl.create :prevision
    FactoryGirl.create :deposito, prevision: prevision, monto: 3
    FactoryGirl.create :deposito, prevision: prevision, monto: 2
    FactoryGirl.create :deposito, prevision: prevision, monto: 6
    FactoryGirl.create :deposito, prevision: prevision, monto: 4, pago_de_comisiones_o_impuestos: true, comisiones: [FactoryGirl.create(:comision, prevision: prevision)]
    assert_equal 11, prevision.reload.monto_depositado
  end

  test '#monto_gastado is the sum of gastos with no comisiones' do
    prevision = FactoryGirl.create :prevision
    apartado = FactoryGirl.create :apartado, prevision: prevision
    FactoryGirl.create :deposito, prevision: prevision, monto: 15
    tope = FactoryGirl.create :tope, monto: 15, prevision: prevision
    tope2 = FactoryGirl.create :tope, monto: 10, prevision: prevision
    FactoryGirl.create :gasto, apartado: apartado, monto: 3, socio: tope.socio
    FactoryGirl.create :gasto, apartado: apartado, monto: 2, socio: tope.socio
    FactoryGirl.create :gasto, apartado: apartado, monto: 6, socio: tope2.socio
    FactoryGirl.create :comision, prevision: prevision, monto: 2
    FactoryGirl.create :comision, prevision: prevision, monto: 1
    assert_equal 11, prevision.reload.monto_gastado
  end

  test 'la fecha es válida si está dentro del rango del periodo' do
    prevision = FactoryGirl.build :prevision, periodo: 2015
    prevision.valid?
    assert prevision.fecha_valida?("2015/02/11".to_date)
  end

  test 'la fecha no es válida si no está dentro del rango del periodo ' do
    prevision = FactoryGirl.build :prevision, periodo: 2015
    prevision.valid?
    refute prevision.fecha_valida?("2016/02/11".to_date)
    refute prevision.fecha_valida?("2014/02/11".to_date)
  end

  test '.de_periodo should return the prevision of this periodo ' do
    FactoryGirl.create :prevision, periodo: 2014
    FactoryGirl.create :prevision, periodo: 2015
    assert_equal 2014, Prevision.de_periodo(2014).periodo
    assert_equal 2015, Prevision.de_periodo(2015).periodo
  end
end

class PrevisionPresenterTest < ActiveSupport::TestCase
  test "#gastos includes gastos between range of dates" do
    prevision = FactoryGirl.create :prevision, :con_deposito, :con_apartado, monto_depositado: 100
    apartado = prevision.apartados.first
    socio = FactoryGirl.create :socio, :con_tope, prevision: prevision, monto_tope: 100
    gasto_1 = FactoryGirl.create :gasto, apartado: apartado, socio: socio, monto: 5, fecha: 1.day.ago
    gasto_2 = FactoryGirl.create :gasto, apartado: apartado, socio: socio, monto: 5, fecha: 1.day.from_now
    rango_fechas = 1.day.ago.to_date..1.day.from_now.to_date
    prevision_presenter = Prevision::PrevisionPresenter.new(prevision, rango_fechas)
    assert_equal [gasto_1, gasto_2].sort, prevision_presenter.gastos.sort
  end

  test "#gastos does not include gastos out of the range of dates" do
    prevision = FactoryGirl.create :prevision, :con_deposito, :con_apartado, monto_depositado: 100
    apartado = prevision.apartados.first
    socio = FactoryGirl.create :socio, :con_tope, prevision: prevision, monto_tope: 100
    gasto_1 = FactoryGirl.create :gasto, apartado: apartado, socio: socio, fecha: 2.days.ago
    gasto_2 = FactoryGirl.create :gasto, apartado: apartado, socio: socio, fecha: 2.days.from_now
    rango_fechas = 1.day.ago.to_date..1.day.from_now.to_date
    prevision_presenter = Prevision::PrevisionPresenter.new(prevision, rango_fechas)
    assert prevision_presenter.gastos.empty?
  end

  test "#depositos includes gastos between range of dates" do
    prevision = FactoryGirl.create :prevision, :con_apartado
    apartado = prevision.apartados.first
    deposito_1 = FactoryGirl.create :deposito, prevision: prevision, fecha: 1.day.ago
    deposito_2 = FactoryGirl.create :deposito, prevision: prevision, fecha: 1.day.from_now
    rango_fechas = 1.day.ago.to_date..1.day.from_now.to_date
    prevision_presenter = Prevision::PrevisionPresenter.new(prevision, rango_fechas)
    assert_equal [deposito_1, deposito_2].sort, prevision_presenter.depositos.sort
  end

  test "#depositos does not include gastos out of the range of dates" do
    prevision = FactoryGirl.create :prevision, :con_apartado
    apartado = prevision.apartados.first
    deposito_1 = FactoryGirl.create :deposito, prevision: prevision, fecha: 2.days.ago
    deposito_2 = FactoryGirl.create :deposito, prevision: prevision, fecha: 2.days.from_now
    rango_fechas = 1.day.ago.to_date..1.day.from_now.to_date
    prevision_presenter = Prevision::PrevisionPresenter.new(prevision, rango_fechas)
    assert prevision_presenter.depositos.empty?
  end

  test "#comisiones includes gastos between range of dates" do
    prevision = FactoryGirl.create :prevision, :con_deposito, :con_apartado, monto_depositado: 100
    comision_1 = FactoryGirl.create :comision, prevision: prevision, monto: 5, fecha: 1.day.ago
    comision_2 = FactoryGirl.create :comision, prevision: prevision, monto: 5, fecha: 1.day.from_now
    rango_fechas = 1.day.ago.to_date..1.day.from_now.to_date
    prevision_presenter = Prevision::PrevisionPresenter.new(prevision, rango_fechas)
    assert_equal [comision_1, comision_2].sort, prevision_presenter.comisiones.sort
  end

  test "#comisiones does not include gastos out of the range of dates" do
    prevision = FactoryGirl.create :prevision, :con_deposito, :con_apartado, monto_depositado: 100
    comision_1 = FactoryGirl.create :comision, prevision: prevision, fecha: 2.days.ago
    comision_2 = FactoryGirl.create :comision, prevision: prevision, fecha: 2.days.from_now
    rango_fechas = 1.day.ago.to_date..1.day.from_now.to_date
    prevision_presenter = Prevision::PrevisionPresenter.new(prevision, rango_fechas)
    assert prevision_presenter.comisiones.empty?
  end
end

# == Schema Information
#
# Table name: previsiones
#
#  id                  :integer          not null, primary key
#  fecha_inicial       :date
#  fecha_final         :date
#  monto               :decimal(, )
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  monto_remanente     :decimal(, )
#  monto_presupuestado :decimal(, )
#
