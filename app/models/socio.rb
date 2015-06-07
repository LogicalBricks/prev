class Socio < ActiveRecord::Base
  # == Associations ==
  belongs_to :usuario
  has_many :gastos
  has_one :tope

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
