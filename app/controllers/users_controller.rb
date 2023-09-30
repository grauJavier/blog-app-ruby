class UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :asc)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def three_most_recent
    @users = User.order(created_at: :desc).limit(3)
  end
end
