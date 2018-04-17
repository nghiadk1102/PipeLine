class CreateMarks < ActiveRecord::Migration[5.1]
  def change
    create_table :marks do |t|
      t.integer :index_mark
      t.string :lat
      t.string :lng
      t.float :height
      t.references :line, foregin_key: true
      t.timestamps
    end
  end
end
