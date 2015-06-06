class CreateJoinTableRolUsuario < ActiveRecord::Migration
  def change
    create_join_table :roles, :usuarios do |t|
      # t.index [:rol_id, :usuario_id]
      # t.index [:usuario_id, :rol_id]
    end
  end
end
