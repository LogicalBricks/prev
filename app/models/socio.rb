class Socio < ActiveRecord::Base
  # == Associations ==
  belongs_to :usuario
  has_one :tope, dependent: :destroy
  has_many :gastos
  has_many :apartados, -> { uniq }, through: :gastos

  accepts_nested_attributes_for :usuario

  # == Validations ==
  validates :nombre, :usuario, presence: true

  # == Methods ==

  def to_s
    nombre
  end

  def monto_disponible(prevision=nil)
    #TODO: take into account the prevision to calculate the correct monto_disponible
    monto_tope - monto_reservado - monto_gastado
  end

  def monto_tope(prevision=nil)
    #TODO: take into account the prevision to calculate the correct monto_tope
    tope.try(:monto).to_f
  end

  def monto_reservado(prevision=nil)
    #TODO: take into account the prevision to calculate the correct monto_reservado
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
    monto_gastado + monto_reservado
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
