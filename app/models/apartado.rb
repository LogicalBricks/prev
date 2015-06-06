class Apartado < ActiveRecord::Base
  # == Associations ==
  belongs_to :rubro
  belongs_to :prevision

  # == Validations ==
  validates :rubro, :prevision, :monto_maximo, presence: true
  validates :monto_maximo, numericality: { greater_than: 0 }
  validate :monto_no_rebasa_monto_de_prevision

  def fecha_inicial
    prevision.fecha_inicial
  end

  def fecha_final
    prevision.fecha_final
  end

private

  def monto_no_rebasa_monto_de_prevision
    errors.add :monto, 'rebasa el monto total del apartado' if prevision and prevision.monto < monto_maximo
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
