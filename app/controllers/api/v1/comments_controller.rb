module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_user

      def index
        @comments = @user.comments
        render json: @comments
      end

      private

      def set_user
        @user = User.find(params[:user_id])
      end
    end
  end
end