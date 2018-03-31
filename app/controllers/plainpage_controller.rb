class PlainpageController < ApplicationController
  def index
  	@pipelines = PipeLine.all
    @posts = Post.all
  end
end
