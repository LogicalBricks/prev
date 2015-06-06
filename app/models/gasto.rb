class Gasto < ActiveRecord::Base
  belongs_to :socio
  belongs_to :proveedor
  belongs_to :apartado
end
