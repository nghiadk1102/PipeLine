class Contruction < ApplicationRecord
  has_many :lines, as: :struction
  belongs_to :contruction_type, optional: true
end
