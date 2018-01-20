class CreatePipeLines < ActiveRecord::Migration[5.1]
  def change
    create_table :pipe_lines do |t|
      t.string :name
      t.float :size_safe
      t.string :description
      t.timestamps
    end
  end
end
