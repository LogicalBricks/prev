class Gasto < ActiveRecord::Base
  # == Associations ==
  belongs_to :socio
  belongs_to :proveedor
  belongs_to :apartado

  # == Validations ==
  validates :socio, presence: true
  validates :monto, numericality: { greater_than: 0 }
end
