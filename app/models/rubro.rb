class Rubro < ActiveRecord::Base
  belongs_to :agrupador

  validates :nombre, :descripcion, presence: true

  def to_s
    nombre
  end
end

# == Schema Information
#
# Table name: rubros
#
#  id           :integer          not null, primary key
#  nombre       :string
#  descripcion  :text
#  agrupador_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
