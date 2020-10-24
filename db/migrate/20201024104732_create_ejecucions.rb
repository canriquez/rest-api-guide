class CreateEjecucions < ActiveRecord::Migration[6.0]
  def change
    create_table :ejecucions do |t|
      t.primary_key :id
      t.references :orden_id, null: false, foreign_key: true
      t.integer :ciclo
      t.string :rutina
      t.string :descripcion
      t.integer :etarget
      t.string :unidad
      t.string :lectura
      t.string :estado
      t.string :obs

      t.timestamps
    end
  end
end
