class PostsController < ApplicationController
	before_action :find_post, only: :show

	def index
		@posts = Post.all
	end

	def create
		post = current_user.posts.build post_params
		if post.save
			flash[:success] = "Create post successfully!"
		else
			flash[:error] = "Create Post error!"
		end

		redirect_to posts_url
	end

	def add; end

	def show; end

	private

	def find_post
		@post = Post.find_by id: params[:id]
	end

	def post_params
		params.permit :title, :tag, :content
	end
end
