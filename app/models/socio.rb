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

class Socio < ActiveRecord::Base
  # == Associations ==
  belongs_to :usuario
  has_many :gastos

  # == Validations ==
  validates :nombre, :usuario, presence: true
end
