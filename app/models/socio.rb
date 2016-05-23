class Socio < ActiveRecord::Base
  # == Associations ==
  belongs_to :usuario
  has_many :topes, dependent: :destroy
  has_one :tope, -> { merge Tope.de_prevision_activa }
  has_many :gastos
  has_many :apartados, -> { uniq }, through: :gastos

  accepts_nested_attributes_for :usuario

  # == Validations ==
  validates :nombre, :usuario, presence: true

  # == Scopes ==
  scope :de_prevision,        -> prevision { joins(:tope).merge Tope.de_prevision(prevision) }
  scope :de_prevision_activa, -> { de_prevision(Prevision.activa) }
  scope :para_listar,         -> { includes(:usuario) }

  # == Methods ==

  def to_s
    nombre
  end

  def monto_disponible(prevision=nil)
    prevision ||= Prevision.activa
    monto_tope - monto_reservado(prevision) - monto_gastado_de_prevision(prevision)
  end

  def monto_tope(prevision=nil)
    tope.try(:monto).to_f
  end

  def monto_reservado(prevision=nil)
    tope.try(:monto_reservado).to_f
  end

  def monto_gastado_de_prevision(prevision)
    gastos.de_prevision(prevision).sum(:monto)
  end

  def monto_gastado(apartado=nil)
    apartado ? monto_gastado_de_apartado(apartado) : monto_gastado_total
  end

  def monto_gastado_total
    gastos.sum(:monto)
  end

  def monto_gastado_de_apartado(apartado)
    gastos.where(apartado: apartado).sum(:monto)
  end

  def monto_gastado_o_reservado
    monto_gastado_de_prevision(Prevision.activa) + monto_reservado(Prevision.activa)
  end

  def monto_cerca_de_limites?(apartado=nil)
    cerca_de_tope? || cerca_de_monto_maximo?(apartado)
  end

  def cerca_de_tope?(prevision=nil)
    (monto_gastado_o_reservado / monto_tope) > 0.8
  end

  def cerca_de_monto_maximo?(apartado)
    (apartado.monto_maximo / monto_gastado_de_apartado(apartado)) > 0.8
  end

  def apartados_de_prevision_activa
    apartados.de_prevision_activa
  end

  def apartados_de_prevision(prevision)
    apartados.de_prevision(prevision)
  end
end

# == Schema Information
#
# Table name: socios
#
#  id         :integer          not null, primary key
#  nombre     :string
#  usuario_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_socios_on_usuario_id  (usuario_id)
#
# Foreign Keys
#
#  fk_rails_0b8e8596bb  (usuario_id => usuarios.id)
#
