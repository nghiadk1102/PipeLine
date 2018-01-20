class CreateLines < ActiveRecord::Migration[5.1]
  def change
    create_table :lines do |t|
      t.string :name
      t.string :description
      t.references :pipe_lines, foregin_key: true
      t.timestamps
    end
  end
end
