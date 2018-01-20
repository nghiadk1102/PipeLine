class Line < ApplicationRecord
  has_many :marks
  has_many :township_lines
  has_many :townships, through: :township_lines

  belongs_to :pipe_line, optional: true
end
