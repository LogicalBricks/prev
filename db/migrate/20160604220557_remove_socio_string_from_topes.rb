class RemoveSocioStringFromTopes < ActiveRecord::Migration
  def change
    remove_column :topes, :socio
  end
end
