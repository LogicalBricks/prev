class Prevision < ActiveRecord::Base
  # == Associations ==
  has_many :depositos, inverse_of: :prevision
  has_many :apartados, inverse_of: :prevision
  has_many :topes, inverse_of: :prevision
  has_many :gastos, through: :apartados

  accepts_nested_attributes_for :apartados, :topes, allow_destroy: true

  # == Validations ==
  validates :fecha_inicial, :fecha_final, :monto, presence: true
  validates :monto, numericality: { greater_than: 0 }
  validate :ensure_date_range

  # == Methods ==

  def monto_gastado
    gastos.sum(:monto)
  end

  def monto_depositado
    depositos.sum(:monto)
  end

private

  def ensure_date_range
    return unless fecha_inicial && fecha_final && fecha_inicial >= fecha_final
    errors.add :base, "La fecha final debe ser mayor a la fecha inicial"
  end
end

# == Schema Information
#
# Table name: previsiones
#
#  id            :integer          not null, primary key
#  fecha_inicial :date
#  fecha_final   :date
#  monto         :decimal(, )
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
