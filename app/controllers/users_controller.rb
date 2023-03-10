class UsersController < ApplicationController
  # load_and_authorize_resource
  # include CanCan::ControllerAdditions
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
