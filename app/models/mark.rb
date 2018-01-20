class Mark < ApplicationRecord
  belongs_to :line, optional: true
end
