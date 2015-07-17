class Deposito < ActiveRecord::Base
  # == Associations ==
  belongs_to :prevision, inverse_of: :depositos

  # == Validations ==
  validates :fecha, :prevision, :monto, presence: true
  validates :monto, numericality: { greater_than: 0 }
  validate :fecha_dentro_de_vigencia_de_prevision
  validate :monto_no_mayor_a_monto_de_prevision

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
#  id           :integer          not null, primary key
#  monto        :decimal(, )
#  fecha        :date
#  descripcion  :text
#  prevision_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
