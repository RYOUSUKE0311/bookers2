class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def create
    @user = User.new(booker_params)
    if @user.save
     flash[:notice] = "Welcome! You have signed up successfully."
     redirect_to user_path(@user.id)
    else
     render :new
    end
  end


  def show
     @user = User.find(params[:id])
     @new_book = Book.new
     @books = @user.books
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your profile was successfully updated."
      redirect_to user_path(@user.id)
    else
      render :edit
    end

  end

  def index
    @user = current_user
    @users = User.all
    @books = current_user.books
    @new_book = Book.new
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
