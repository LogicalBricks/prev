class Socio < ActiveRecord::Base
  # == Associations ==
  belongs_to :usuario
  has_one :tope
  has_many :gastos
  has_many :apartados, -> { uniq }, through: :gastos

  accepts_nested_attributes_for :usuario

  # == Validations ==
  validates :nombre, :usuario, presence: true

  # == Methods ==

  def monto
    tope.monto if tope
  end

  def to_s
    nombre
  end

  def monto_gastado_de_prevision(prevision)
    gastos.de_prevision(prevision).sum(:monto)
  end

  def monto_gastado(apartado=nil)
    apartado ? gastos.where(apartado: apartado).sum(:monto) : gastos.sum(:monto)
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
