class Apartado < ActiveRecord::Base
  belongs_to :rubro
  belongs_to :prevision
end
