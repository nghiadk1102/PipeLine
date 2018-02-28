class PipelinesController < ApplicationController
	before_action :load_pipeline, only: :update

	def index
		@pipelines = PipeLine.all
	end

	def update
		if @pipeline.update_attributes pipeline_params
			flash[:notice] = "Update successfully"
		else
			flash[:notice] = "Update error"
		end
	end

	private

	def load_pipeline
		@pipeline = PipeLine.find_by id: params[:id]
	end

	def pipeline_params
		params.require(:pipe_line).permit :name, :size_safe, :description
	end
end
