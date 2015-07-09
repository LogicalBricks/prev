class Prevision < ActiveRecord::Base
  attr_accessor :periodo

  # == Associations ==
  has_many :depositos, inverse_of: :prevision
  has_many :apartados, inverse_of: :prevision
  has_many :topes, inverse_of: :prevision
  has_many :comisiones, inverse_of: :prevision
  has_many :gastos, through: :apartados

  accepts_nested_attributes_for :apartados, :topes, allow_destroy: true

  # == Validations ==
  validates :periodo, :monto_presupuestado, presence: true
  validates :monto_remanente, numericality: true, if: "monto_remanente.present?"
  validates :monto_presupuestado, numericality: { greater_than: 0 }

  # == Callbacks ==
  after_initialize :calcula_periodo
  before_validation :calcula_fechas
  before_validation :calcula_monto

  # == Methods ==

  def monto_gastado
    gastos.sum(:monto) + comisiones.sum(:monto)
  end

  def monto_depositado
    depositos.sum(:monto)
  end

  def to_s
    periodo.to_s
  end

  def fecha_valida?(fecha)
    fecha >= fecha_inicial && fecha <= fecha_final
  end

private

  def calcula_periodo
    @periodo ||= fecha_inicial.year if fecha_inicial
  end

  def calcula_fechas
    self.fecha_inicial = "#{periodo}/01/01".to_date
    self.fecha_final = "#{periodo}/12/31".to_date
  end

  def calcula_monto
    self.monto = monto_remanente.to_f + monto_presupuestado.to_f
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
