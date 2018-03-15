class IntersectMark < ApplicationRecord
	belongs_to :first_line, class_name: Line.name, dependent: :destroy, foreign_key: "first_line_id"
	belongs_to :second_line, class_name: Line.name, dependent: :destroy
end
