class CreateLines < ActiveRecord::Migration[5.1]
  def change
    create_table :lines do |t|
      t.string :name
      t.string :description
      t.string :color
      t.references :pipe_line, foregin_key: true
      t.timestamps
    end
  end
end
