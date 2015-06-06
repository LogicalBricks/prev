class Socio < ActiveRecord::Base
  # == Associations ==
  belongs_to :usuario
  has_many :gastos

  # == Validations ==
  validates :nombre, :usuario, presence: true
end
