class UsersController < ApplicationController

  before_action :ensure_current_user, {only: [:edit, :update]}
  
  def index
    @users = User.all
    @book = Book.new
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = "You have updated user successfully."
    else
      render :edit
    end
  end
  
  def ensure_current_user
    if current_user.id != User.find(params[:id]).id
      redirect_to user_path(current_user.id)
      flash[:notice] = "権限がありません"
    end
  end

  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
