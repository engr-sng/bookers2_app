class BooksController < ApplicationController

  before_action :ensure_current_user, {only: [:edit, :update, :destroy]}

  def index
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end

  def show
    @book = Book.new
    @bookshow = Book.find(params[:id])
    @user = User.find(@bookshow.user_id)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = User.find(current_user.id)
    @books = Book.all
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] = "You have created book successfully."
    else
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:notice] = "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
    flash[:notice] = "You have destroy book successfully."
  end  

  def ensure_current_user
    if current_user.id != Book.find(params[:id]).user_id
      redirect_to books_path
      flash[:notice] = "権限がありません"
    end
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
