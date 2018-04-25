class ContructionTypesController < ApplicationController
  before_action :load_contruction_types, only: [:update, :destroy]

  def index
    @contruction_types = ContructionType.all
    @new_contruction_type = ContructionType.new
  end

  def create
    contruction_type = ContructionType.new contruction_types_params

    if contruction_type.save
      flash[:success] = "Create Contruction Type successfully"
    else
      flash[:error] = "Create Contruction Type error"
    end
    redirect_to contruction_types_path
  end

  def update
    if @ContructionType.update_attributes contruction_types_params
      flash[:success] = "Update PipeLine successfully"
    else
      flash[:error] = "Update PipeLine error"
    end
    redirect_to contruction_types_path
  end

  def destroy
    if @ContructionType.destroy
      flash[:success] = "Delete PipeLine successfully"
    else
      flash[:error] = "Update PipeLine error"
    end
    redirect_to contruction_types_path
  end

  private

  def load_contruction_types
    @ContructionType = ContructionType.find_by id: params[:id]
  end

  def contruction_types_params
    params.require(:contruction_type).permit :name, :description
  end
end
