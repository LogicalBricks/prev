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

  def monto_disponible(prevision=nil)
    #TODO: take into account the prevision to calculate the correct monto_disponible
    tope ? tope.monto.to_f - tope.monto_reservado.to_f : 0
  end

  def monto_tope(prevision=nil)
    #TODO: take into account the prevision to calculate the correct monto_tope
    tope.try(:monto).to_f
  end

  def monto_reservado(prevision=nil)
    #TODO: take into account the prevision to calculate the correct monto_reservado
    tope.try(:monto_reservado).to_f
  end

  def to_s
    nombre
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
