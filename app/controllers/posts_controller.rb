class PostsController < ApplicationController
  before_action   :logged_in_user,   only: [:new, :create]

  def new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "You've posted successfully!"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

end


private

  # for added security
  def post_params
    params.require(:post).permit(:header, :content)
  end
