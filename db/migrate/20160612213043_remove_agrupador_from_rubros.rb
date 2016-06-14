class RemoveAgrupadorFromRubros < ActiveRecord::Migration
  def change
    remove_column :rubros, :agrupador_id
  end
end
