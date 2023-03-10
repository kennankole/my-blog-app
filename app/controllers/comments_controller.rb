class CommentsController < ApplicationController
  load_and_authorize_resource
  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = Post.find(params[:post_id])

    if @comment.save
      redirect_to user_post_path(@comment.post.author, @comment.post)
    else
      render :new
    end
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    @user = @post.author
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to user_posts_path(user_id: @comment.author_id), notice: 'Post deleted successfully'
    else
      puts @comments.errors.full_messages
      redirect_to user_posts_path, notice: 'There was an error in deleting the post'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
