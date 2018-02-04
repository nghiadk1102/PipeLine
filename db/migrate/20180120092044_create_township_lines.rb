class CreateTownshipLines < ActiveRecord::Migration[5.1]
  def change
    create_table :township_lines do |t|
      t.references :line, foregin_key: true
      t.references :township, foregin_key: true
      t.timestamps
    end
  end
end
