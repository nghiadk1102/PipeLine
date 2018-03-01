class PipelinesController < ApplicationController
	before_action :load_pipeline, only: [:update, :destroy]

	def index
		@pipelines = PipeLine.all
		@new_pipeline = PipeLine.new
	end

	def create
		pipeline = PipeLine.new pipeline_params

		if pipeline.save
			flash[:success] = "Create PipeLine successfully"
		else
			flash[:error] = "Create PipeLine error"
		end
		redirect_to pipelines_path
	end

	def update
		if @pipeline.update_attributes pipeline_params
			flash[:success] = "Update PipeLine successfully"
		else
			flash[:error] = "Update PipeLine error"
		end
		redirect_to pipelines_path
	end

	def destroy
		if @pipeline.destroy
			flash[:success] = "Delete PipeLine successfully"
		else
			flash[:error] = "Update PipeLine error"
		end
		redirect_to pipelines_path
	end

	private

	def load_pipeline
		@pipeline = PipeLine.find_by id: params[:id]
	end

	def pipeline_params
		params.require(:pipe_line).permit :name, :size_safe, :description
	end
end
