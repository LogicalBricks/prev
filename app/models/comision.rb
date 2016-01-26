class Comision < ActiveRecord::Base
  # == Associations ==
  belongs_to :prevision, inverse_of: :comisiones

  # == Validations ==
  validates :prevision, presence: true

  # == Scopes ==

  scope :de_prevision_activa, -> { where(prevision: Prevision.activa) }
  scope :para_listar, -> { includes(:prevision).de_prevision_activa }
end

# == Schema Information
#
# Table name: comisiones
#
#  id               :integer          not null, primary key
#  monto            :decimal(, )
#  descripcion      :string
#  fecha            :date
#  prevision_id     :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  fecha_reposicion :date
#  comentario       :text
#
# Indexes
#
#  index_comisiones_on_prevision_id  (prevision_id)
#
# Foreign Keys
#
#  fk_rails_33e568a893  (prevision_id => previsiones.id)
#
