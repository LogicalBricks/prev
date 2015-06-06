class Deposito < ActiveRecord::Base
  # == Associations ==
  belongs_to :prevision, inverse_of: :depositos

  # == Validations ==
  validates :fecha, :prevision, presence: true
  validates :monto, numericality: { greater_than: 0 }
  validate :fecha_dentro_de_vigencia_de_prevision

private

  def fecha_dentro_de_vigencia_de_prevision
    errors.add :fecha, 'debe ser posterior al inicio de la prevision' if prevision and fecha < prevision.fecha_inicial
    errors.add :fecha, 'debe ser anterior al final de la prevision' if prevision and fecha > prevision.fecha_final
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
