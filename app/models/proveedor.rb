class Proveedor < ActiveRecord::Base
  # == Associations ==
  has_many :gastos

  # == Validations ==
  validates :nombre, presence: true

  def to_s
    nombre
  end
end

# == Schema Information
#
# Table name: proveedores
#
#  id         :integer          not null, primary key
#  nombre     :string
#  rfc        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
