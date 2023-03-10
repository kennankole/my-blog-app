module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_user
      skip_before_action :verify_authenticity_token

      def index
        @comments = @user.comments
        render json: @comments
      end

      def create
        post = Post.find(params[:post_id])
        comment = post.comments.create(comment_params)
        render json: comment
      end

      private

      def set_user
        @user = User.find(params[:user_id])
      end

      def comment_params
        params.require(:comment).permit(:text).merge(author_id: current_user&.id || 0)
      end
    end
  end
end
