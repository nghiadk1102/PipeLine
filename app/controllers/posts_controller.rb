class PostsController < ApplicationController
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

	private

	def post_params
		params.permit :title, :tag, :content
	end
end
