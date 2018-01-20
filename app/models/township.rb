class Township < ApplicationRecord
  has_many :township_lines
  has_many :lines, through: :township_lines
end
