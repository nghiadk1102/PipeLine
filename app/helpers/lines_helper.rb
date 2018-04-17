module LinesHelper
	def pipeline_for_select
		PipeLine.all
	end

	def contruction_type_for_select
		ContructionType.all
	end

	def find_intersect_line id, first_id, second_id
		if id == first_id
			name = Line.where(id: second_id).first&.name
			return  link_to name, line_path(second_id)
		else
			name = Line.where(id: first_id).first&.name
			return link_to name, line_path(first_id)
		end
	end
end
