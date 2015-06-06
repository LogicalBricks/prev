class Proveedor < ActiveRecord::Base
  # == Associations ==
  has_many :gastos

  # == Validations ==
  validates :nombre, presence: true
end
