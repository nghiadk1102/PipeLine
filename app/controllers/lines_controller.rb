class LinesController < ApplicationController
	before_action :load_line, only: [:update, :destroy]

	def index
		@lines = Line.all
    @new_line = Line.new
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

  def destroy
  	if @line.destroy
    	flash[:success] = "Delete Line successfully"
    else
	   	flash[:error] = "Delete line error"
    end
    redirect_to lines_url
  end

  private

  def load_line
		@line = Line.find_by id: params[:id]
	end

  def lineparams
  	params.require(:line).permit :name,  :description, :pipe_line_id, marks_attributes: [:lat, :lng, :index_mark]
  end

  def random_color
    "#%06x" % (rand * 0xffffff)
  end
end
