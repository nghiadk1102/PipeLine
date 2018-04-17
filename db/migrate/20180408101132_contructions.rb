class Contructions < ActiveRecord::Migration[5.1]
  def change
    create_table :contructions do |t|
      t.string :name
      t.text :description
      t.float :min_height
      t.float :max_height
      t.references :contruction_types, foreign_key: true
    end
  end
end
