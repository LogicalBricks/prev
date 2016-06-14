class RemoveActivaFromPrevision < ActiveRecord::Migration
  def change
    remove_column :previsiones, :activa
  end
end
