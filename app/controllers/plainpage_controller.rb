class PlainpageController < ApplicationController
  def index
  	@pipelines = PipeLine.all
  end
end
