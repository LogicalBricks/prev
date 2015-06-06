class Rubro < ActiveRecord::Base
  belongs_to :agrupador

  validates :nombre, :descripcion, presence: true
end
