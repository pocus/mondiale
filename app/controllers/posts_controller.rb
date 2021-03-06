class PostsController < ApplicationController
	before_action :set_post, only: [:edit, :update, :destroy, :vote]

	def new
		@chapter = Chapter.find(params[:chapter_id])
		@post = Post.new( chapter_id: @chapter.id )
   	@post_attachment = @post.post_attachments.build

   	respond_to do |format|
      format.html
      format.js
    end
	end

	def create
		@chapter = Chapter.find(params[:chapter_id])
		@post = @chapter.posts.new(post_params)
			respond_to do |format|
		if @post.save
			save_images
			format.html do
			flash[:success] = "Your post has been created successfully"
			redirect_to trip_chapter_path(@post.trip, @post.chapter)
			end
			format.js
		else
			format.html {render :new}
			format.js
		end
	 end
	end

	def edit
		@chapter = Chapter.find(params[:chapter_id])
    @post = Post.find(params[:id])
    @post_attachment = @post.post_attachments.build
	end

	def update
	@chapter = Chapter.find(params[:chapter_id])
	@posts = @chapter.posts

	respond_to do |format|
		if @post.update(post_params)
			save_images
			format.html do
				flash[:success] = "Your post has been updated successfully"
				redirect_to trip_chapter_path(@post.trip, @post.chapter)
			end
			format.js
		else
			format.html {render :edit}
			format.js
		end
	end
	end

	def destroy
		@chapter = Chapter.find(params[:chapter_id])
		respond_to do |format|
		if @post.destroy
			@posts = @chapter.posts
			format.html do
				flash[:success] = "Your post has been deleted successfully"
				redirect_to trip_chapter_path(@post.trip, @post.chapter)
			end
			format.js {flash.now[:success] = "gone"}
		else
			format.html {render :show}
			format.js
		end
		end
	end


private

	def save_images
		if params[:post_attachments]
			params[:post_attachments]['postimage'].each do |a|
	   	  @post_attachment = @post.post_attachments.create!(:postimage => a, :post_id => @post.id)
    	end
  	end
	end

	def set_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :content, :date, :location, :post_attachments, :inspiration_id, :inspiration_type)
	end

end
