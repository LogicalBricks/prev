class Tope < ActiveRecord::Base
  # == Associations ==
  belongs_to :prevision, inverse_of: :topes
  belongs_to :socio

  # == Validations ==
  validates :monto, :prevision, :socio, presence: true
  validates :monto, numericality: { greater_than: 0 }
  validates :monto_reservado, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true

  # == Scopes ==
  scope :de_prevision, -> prevision { where(prevision: prevision) }
  scope :de_prevision_activa, -> { de_prevision(Prevision.activa) }
end

# == Schema Information
#
# Table name: topes
#
#  id              :integer          not null, primary key
#  socio           :string
#  monto           :decimal(, )
#  prevision_id    :integer
#  socio_id        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  monto_reservado :decimal(, )
#
# Indexes
#
#  index_topes_on_prevision_id  (prevision_id)
#  index_topes_on_socio_id      (socio_id)
#
# Foreign Keys
#
#  fk_rails_3021cc1f14  (prevision_id => previsiones.id)
#  fk_rails_fc588aedfb  (socio_id => socios.id)
#
