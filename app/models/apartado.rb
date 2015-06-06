class Apartado < ActiveRecord::Base
  # == Associations ==
  belongs_to :rubro
  belongs_to :prevision

  # == Validations ==
  validates :rubro, :prevision, :monto_maximo, presence: true
  validates :monto_maximo, numericality: { greater_than: 0 }
  validate :monto_no_rebasa_monto_de_prevision

private

  def monto_no_rebasa_monto_de_prevision
    errors.add :monto, 'rebasa el monto total del apartado'
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
