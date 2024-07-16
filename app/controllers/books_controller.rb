class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @new_book = Book.new
  end

  def create
    @new_book = current_user.books.new(booker_params)
    if @new_book.save
     flash[:notice] = "Book was successfully created."
     redirect_to book_path(@new_book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @new_book = Book.new

  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    @user = current_user
  end

  def update
     @book = Book.find(params[:id])
     if @book.update(booker_params)
      redirect_to book_path(@book.id)
      flash[:notice] = "Book was successfully updated."
     else
      flash.now[:notice] =  "Book was not successfully updated."
      # @booker = Book.find(params[:id]
       render :edit
     end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to "/books"
  end

  private
  def booker_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end
end