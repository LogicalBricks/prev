class Comision < ActiveRecord::Base
  # == Associations ==
  belongs_to :prevision, inverse_of: :comisiones
  belongs_to :deposito, inverse_of: :comisiones

  # == Validations ==
  validates :prevision, :fecha, presence: true

  # == Scopes ==

  scope :de_prevision,                 -> prevision { where(prevision: prevision) }
  scope :de_prevision_activa,          -> { de_prevision(Prevision.activa) }
  scope :para_listar,                  -> { includes(:prevision).de_prevision_activa }
  scope :sin_deposito,                 -> { where(deposito_id: nil) }
  scope :para_seleccionar_en_deposito, -> { de_prevision_activa }

  # == Methods ==

  def to_s
    "#{fecha_formateada} #{monto_formateado} - #{descripcion}"
  end

  def to_be_paid?
    deposito_id.blank?
  end

private

  def fecha_formateada
    "[#{I18n.l fecha}]" if fecha
  end

  def monto_formateado
    ActionController::Base.helpers.number_to_currency(monto)
  end
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
#  deposito_id      :integer
#
# Indexes
#
#  index_comisiones_on_prevision_id  (prevision_id)
#
# Foreign Keys
#
#  fk_rails_33e568a893  (prevision_id => previsiones.id)
#
