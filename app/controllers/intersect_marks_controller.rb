class IntersectMarksController < ApplicationController
	def index
		line = Line.find_by(id: params[:line_id])
		render json: {status: "error", message: "Line is not Found"} unless line
		intersect_marks = IntersectMark.where("first_line_id = ? OR second_line_id = ?", params[:line_id], params[:line_id]).pluck(:id, :lat, :lng)
		render json: {status: "success", data: intersect_marks}
	end
end