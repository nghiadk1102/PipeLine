class FilterlineController < ApplicationController
  def filter
    @data = {}
    pipe_line_names = filter_params.keys
    return render json: {message: "successfully"} if pipe_line_names.blank?
    pipe_line_names.each do |pipeline|
      pipeline = PipeLine.find_by name: pipeline
      if pipeline
        @data[pipeline.name] = []
        pipeline.lines.each do |line|
          @data[pipeline.name] << {"#{line.name}": {id: line.id, color: line.color, radius: line.radius, marks: []}}
          marks = Mark.where(line_id: line.id).order(index_mark: "ASC")
          marks.each do |mark|
            @data[pipeline.name].last[line.name.to_sym][:marks] << {
              lat: mark.lat.to_f,
              lng: mark.lng.to_f
            }
          end
        end
      end
    end
    render json: {message: "successfully", data: @data}
  end

  private

  def filter_params
    params
  end
end
