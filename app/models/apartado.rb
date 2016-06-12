class Apartado < ActiveRecord::Base
  # == Associations ==
  belongs_to :rubro
  belongs_to :prevision
  has_many :gastos
  has_many :socios, -> { uniq }, through: :gastos

  # == Validations ==
  validates :rubro, :prevision, :monto_maximo, presence: true
  validates :monto_maximo, numericality: { greater_than: 0 }
  validate :monto_no_rebasa_monto_de_prevision

  # == Scopes ==
  scope :de_prevision,              -> prevision { where(prevision: prevision) }
  scope :de_prevision_activa,       -> { de_prevision(Prevision.default) }
  scope :para_seleccionar_en_gasto, -> { includes(:prevision, :rubro).de_prevision_activa }

  # == Methods ==

  delegate :monto, to: :prevision, prefix: true, allow_nil: true

  def fecha_inicial
    prevision.fecha_inicial
  end

  def fecha_final
    prevision.fecha_final
  end

  def to_s
    "#{ rubro } - #{ prevision.fecha_inicial.year }"
  end

  def monto_gastado
    gastos.sum(:monto)
  end

  def suma_monto_gastado
    gastos.to_a.sum(&:monto)
  end

  def monto_gastado_por_socio(socio)
    gastos.de_socio(socio).sum(:monto)
  end

private

  def monto_no_rebasa_monto_de_prevision
    errors.add :monto_maximo, :exceeds_monto_prevision if prevision_monto.to_f < monto_maximo.to_f
  end
end

# == Schema Information
#
# Table name: apartados
#
#  id           :integer          not null, primary key
#  monto_maximo :decimal(, )
#  rubro_id     :integer
#  prevision_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_apartados_on_prevision_id  (prevision_id)
#  index_apartados_on_rubro_id      (rubro_id)
#
# Foreign Keys
#
#  fk_rails_a7b482130a  (rubro_id => rubros.id)
#  fk_rails_b96ecf8df7  (prevision_id => previsiones.id)
#
