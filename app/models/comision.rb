class Comision < ActiveRecord::Base
  # == Associations ==
  belongs_to :prevision, inverse_of: :comisiones

  # == Validations ==
  validates :prevision, presence: true
end

# == Schema Information
#
# Table name: comisiones
#
#  id           :integer          not null, primary key
#  monto        :decimal(, )
#  descripcion  :string
#  fecha        :date
#  prevision_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_comisiones_on_prevision_id  (prevision_id)
#
# Foreign Keys
#
#  fk_rails_33e568a893  (prevision_id => previsiones.id)
#
