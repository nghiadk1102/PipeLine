class CreateMarks < ActiveRecord::Migration[5.1]
  def change
    create_table :marks do |t|
      t.integer :prev_mark_id
      t.string :lat
      t.string :lng
      t.string :height
      t.references :lines, foregin_key: true
      t.timestamps
    end
  end
end
