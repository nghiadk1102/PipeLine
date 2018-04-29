class CreateLines < ActiveRecord::Migration[5.1]
  def change
    create_table :lines do |t|
      t.string :name
      t.text :description
      t.string :color
      t.integer :struction_id
      t.string :struction_type
      t.string :radius
      t.timestamps
    end
  end
end
