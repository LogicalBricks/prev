class Deposito < ActiveRecord::Base
  # == Associations ==
  belongs_to :prevision, inverse_of: :depositos
  belongs_to :gasto, inverse_of: :deposito

  # == Validations ==
  validates :fecha, :prevision, :monto, presence: true
  validates :monto, numericality: { greater_than: 0 }
  validates :gasto, absence: true, unless: :pago_de_comisiones_o_impuestos
  validate :fecha_dentro_de_vigencia_de_prevision
  validate :monto_no_mayor_a_monto_de_prevision

  # == Scopes ==
  scope :de_gastos,           -> { where(pago_de_comisiones_o_impuestos: false) }
  scope :de_prevision_activa, -> { where(prevision: Prevision.activa) }
  scope :para_listar,         -> { de_gastos.de_prevision_activa.preload :prevision }

  # == Methods ==

  delegate :monto_depositado, :fecha_valida?, to: :prevision, allow_nil: true
  delegate :monto, to: :prevision, prefix: true, allow_nil: true

private

  def fecha_dentro_de_vigencia_de_prevision
    errors.add :fecha, :invalid unless fecha_valida?(fecha)
  end

  def monto_no_mayor_a_monto_de_prevision
    errors.add :monto, :exceeds_monto_prevision if monto_excede_monto_de_prevision?
  end

  def monto_excede_monto_de_prevision?
    monto_a_aumentar + monto_depositado.to_f > prevision_monto.to_f
  end

  def monto_a_aumentar
    monto.to_f - monto_was.to_f
  end
end

# == Schema Information
#
# Table name: depositos
#
#  id                             :integer          not null, primary key
#  monto                          :decimal(, )
#  fecha                          :date
#  descripcion                    :text
#  prevision_id                   :integer
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  pago_de_comisiones_o_impuestos :boolean          default(FALSE)
#  referencia                     :string
#  gasto_id                       :integer
#
# Indexes
#
#  index_depositos_on_prevision_id  (prevision_id)
#
# Foreign Keys
#
#  fk_rails_2f3f35ef6b  (gasto_id => gastos.id)
#  fk_rails_3728a922f6  (prevision_id => previsiones.id)
#
