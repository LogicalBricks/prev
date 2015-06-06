class Tope < ActiveRecord::Base
  # == Associations ==
  belongs_to :prevision, inverse_of: :topes
  belongs_to :socio

  # == Validations ==
  validates :monto, :prevision, :socio, presence: true
  validates :monto, numericality: { greater_than: 0 }
end

# == Schema Information
#
# Table name: topes
#
#  id           :integer          not null, primary key
#  socio        :string
#  monto        :decimal(, )
#  prevision_id :integer
#  socio_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_topes_on_prevision_id  (prevision_id)
#  index_topes_on_socio_id      (socio_id)
#

