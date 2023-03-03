class PostsController < ApplicationController
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

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
