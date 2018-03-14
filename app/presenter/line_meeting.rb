class line_meeting
	def initalize line1, line2
		@line1 = line1
		@line2 = line2
	end

	def checking
		max_lng_line1 = 0
		max_lat_line1 = 0
		@line1.marks.each do |mark|
			if max_lng_line1 > mark.lng
				max_lng_line1 = mark.lng
			end

			if max_lat_line1 > mark.lng
				max_lat_line1 = mark.lng
			end
		end
	end
end