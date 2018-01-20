class TownshipLine < ApplicationRecord
  belongs_to :line
  belongs_to :township
end
