class Prevision < ActiveRecord::Base
  class << self
    def activa
      last
    end
  end

  attr_accessor :periodo

  # == Associations ==
  has_many :depositos, inverse_of: :prevision
  has_many :apartados, inverse_of: :prevision
  has_many :topes, inverse_of: :prevision
  has_many :comisiones, inverse_of: :prevision
  has_many :gastos, through: :apartados
  has_many :socios, through: :topes

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
    gastos.sum(:monto).to_f
  end

  def monto_reservado
    topes.sum(:monto_reservado)
  end

  def monto_gastado_o_reservado
    monto_gastado + monto_reservado
  end

  def monto_depositado
    depositos.sum(:monto).to_f
  end

  def to_s
    periodo.to_s
  end

  def fecha_valida?(fecha)
    rango_fechas.includes?(fecha)
  end

  def self.de_periodo(year)
    date_range = DateRange.new(year)
    where(
      fecha_inicial: date_range.initial,
      fecha_final: date_range.final
    ).first
  end

private

  def calcula_periodo
    @periodo ||= fecha_inicial.year if fecha_inicial
  end

  def calcula_fechas
    return unless periodo

    date_range = DateRange.new(periodo)
    self.fecha_inicial = date_range.initial
    self.fecha_final = date_range.final
  end

  def calcula_monto
    self.monto = monto_remanente.to_f + monto_presupuestado.to_f
  end

  def rango_fechas
    @rango_fechas ||= DateRange.new(fecha_inicial, fecha_final)
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
