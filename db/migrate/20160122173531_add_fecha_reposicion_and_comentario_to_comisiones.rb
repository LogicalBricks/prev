class AddFechaReposicionAndComentarioToComisiones < ActiveRecord::Migration
  def change
    add_column :comisiones, :fecha_reposicion, :date
    add_column :comisiones, :comentario, :text
  end
end
