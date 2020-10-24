class CreateOrdens < ActiveRecord::Migration[6.0]
  def change
    create_table :ordens do |t|
      t.primary_key :id
      t.string :creator
      t.string :mezcla
      t.string :target
      t.string :obs

      t.timestamps
    end
  end
end
