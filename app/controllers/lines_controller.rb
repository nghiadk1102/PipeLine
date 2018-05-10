class LinesController < ApplicationController
	before_action :load_line, only: [:update, :destroy, :show]

	def index
		@lines = Line.all
    @new_line = Line.new
    data = []
    @lines.each do |line|
      marks = line.marks.pluck(:lat, :lng)
      data << {id: line.id, name: line.name, marks: marks}
    end
    respond_to do |format|
      format.html
      format.json {render json: {data: data, message: "success"}}
    end
	end

  def show
    @marks = Mark.where(line_id: @line.id).order(index_mark: :ASC)
    @intersect_marks = IntersectMark.where("first_line_id = ? OR second_line_id = ?", @line.id, @line.id)
    data = {color: @line.color, marks: []}
    @marks.each do |mark|
      data[:marks] << {
        lat: mark.lat.to_f,
        lng: mark.lng.to_f
      }
    end
    respond_to do |format|
      format.html
      format.json {render json: {data: data, message: "success"}}
    end
  end

  def create
    line = Line.new lineparams
    line.color = random_color
    if line.save
    	flash[:success] = "Create Line successfully"
	   else
	   	flash[:error] = "Create line error"
    end
    redirect_to lines_url
  end

  def update
    if @line.update_attributes lineparams
      flash[:success] = "Update Line successfully"
    else
      flash[:error] = "Update Line error"
    end
    redirect_to lines_path
  end

  def destroy
  	if @line&.destroy
    	flash[:success] = "Delete Line successfully"
    else
	   	flash[:error] = "Delete line error"
    end
    redirect_to lines_url
  end

  private

  def load_line
    return unless params[:id]
		@line = Line.find_by id: params[:id]
	end

  def lineparams
  	params.require(:line).permit :name,  :description, :struction_id, :struction_type, :radius, marks_attributes: [:lat, :lng, :height, :index_mark]
  end

  def random_color
    "#%06x" % (rand * 0xffffff)
  end
end
