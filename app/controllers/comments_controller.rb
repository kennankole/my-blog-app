class CommentsController < ApplicationController
  def create
    @post = current_user.posts.find(params[:id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to post_path(@comment.post)
    else
      head :no_content
      puts @comment.errors.full_messages
    end
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
