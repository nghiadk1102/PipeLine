class ContructionTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :contruction_types do |t|
      t.string :name
      t.text :description
    end
  end
end
