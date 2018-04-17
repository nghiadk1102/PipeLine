class ContructionsController < ApplicationController
  before_action :load_contruction, only: [:update, :destroy]

  def index
    @contructions = Contruction.all
    @new_contruction = Contruction.new
  end

  def create
    contruction = Contruction.new contructions_params

    if contruction.save
      flash[:success] = "Create Contruction successfully"
    else
      flash[:error] = "Create Contruction error"
    end
    redirect_to contructions_path
  end

  def update
    if @Contruction.update_attributes contructions_params
      flash[:success] = "Update PipeLine successfully"
    else
      flash[:error] = "Update PipeLine error"
    end
    redirect_to contructions_path
  end

  def destroy
    if @Contruction.destroy
      flash[:success] = "Delete PipeLine successfully"
    else
      flash[:error] = "Update PipeLine error"
    end
    redirect_to contructions_path
  end

  private

  def load_contruction
    @Contruction = Contruction.find_by id: params[:id]
  end

  def contructions_params
    params.require(:contruction).permit :name, :description, :max_height, :min_height,
      :contruction_types_id
  end
end
