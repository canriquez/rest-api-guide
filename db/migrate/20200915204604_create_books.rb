class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.text :title
      t.text :author
      t.text :category

      t.timestamps
    end
  end
end
