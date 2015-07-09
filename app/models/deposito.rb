class Deposito < ActiveRecord::Base
  # == Associations ==
  belongs_to :prevision, inverse_of: :depositos

  # == Validations ==
  validates :fecha, :prevision, presence: true
  validates :monto, numericality: { greater_than: 0 }
  validate :fecha_dentro_de_vigencia_de_prevision
  validate :monto_no_mayor_a_monto_de_prevision

private

  def fecha_dentro_de_vigencia_de_prevision
    errors.add :fecha, 'debe estar en el rango de fechas de la previsión' if prevision and !prevision.fecha_valida?(fecha)
  end

  def monto_no_mayor_a_monto_de_prevision
    errors.add :monto, 'no debe superar el monto de la previsión' if prevision and monto + prevision.depositos.sum(:monto) > prevision.monto
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
