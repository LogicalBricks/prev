class Agrupador < ActiveRecord::Base
  has_many :rubros

  validates :nombre, presence: true

  def to_s
    nombre
  end
end

# == Schema Information
#
# Table name: agrupadores
#
#  id         :integer          not null, primary key
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
