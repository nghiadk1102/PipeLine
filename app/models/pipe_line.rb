class PipeLine < ApplicationRecord
  has_many :lines, as: :struction
end
