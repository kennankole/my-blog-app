class PostsController < ApplicationController
  load_and_authorize_resource
 
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to url_for(controller: 'users', action: 'index')
    else
      puts @post.errors.full_messages
    end
  end

  def like
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @like = Like.find_or_create_by(author: current_user, post: @post)
    @like.update_likes_counter
    redirect_to url_for(controller: 'posts', action: 'show', id: @post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to user_posts_path(user_id: @post.author_id), notice: "Post deleted successfully"
    else
      puts @posts.errors.full_messages
      redirect_to user_posts_path, notice: 'There was an error in deleting the post'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
