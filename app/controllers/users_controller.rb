class UsersController < ApplicationController

  def new 
    @user = User.new
    @user.username = 'Sava McSavvy'
  end

  def create
    @user = User.new(user_params)
   
    if @user.save
      redirect_to new_users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
