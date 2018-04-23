class Line < ApplicationRecord
  has_many :marks
  has_many :township_lines
  has_many :townships, through: :township_lines
  has_many :intersect_marks, foreign_key: "first_line_id"

  belongs_to :pipe_line, optional: true
  accepts_nested_attributes_for :marks

  after_create :check_intersect_line

  delegate :name, to: :pipe_line, prefix: true

  validates :name, presence: true
  def max_lat
  	self.marks.pluck(:lat).max
  end

  def min_lat
  	self.marks.pluck(:lat).min
  end

  def max_lng
  	self.marks.pluck(:lng).max
  end

  def min_lng
  	self.marks.pluck(:lng).min
  end

  private

  def check_intersect_line
    Line.all.where.not(id: self.id).each do |line|
      values = LineMeeting.checking self, line
      if values
        values.each do |value|
  				self.intersect_marks.create! lat: value[:lat], lng: value[:lng], second_line_id: line.id
  			end
  		end
  	end
  end
end
