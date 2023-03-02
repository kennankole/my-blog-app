class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.build(user_id: current_user.id, post_id: @post.id)
  end
end
