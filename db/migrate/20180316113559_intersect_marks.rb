class IntersectMarks < ActiveRecord::Migration[5.1]
  def change
  	create_table :intersect_marks do |t|
  		t.string :lat
  		t.string :lng
      t.string :height
  		t.string :description
  		t.integer :first_line_id
  		t.integer :second_line_id
  	end
  end
end
