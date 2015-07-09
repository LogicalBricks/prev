class Rubro < ActiveRecord::Base
  # == Validations ==
  validates :nombre, presence: true

  # == Methods ==

  def to_s
    nombre
  end
end

# == Schema Information
#
# Table name: rubros
#
#  id          :integer          not null, primary key
#  nombre      :string
#  descripcion :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
