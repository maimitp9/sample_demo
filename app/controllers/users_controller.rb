class UsersController < ApplicationController

  def index

  end
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
  def edit

  end
  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    if @user.save
      flash[:success] = "Welcome #{@user.name}"
      redirect_to @user
    else
      flash[:error] = "Sorry there was problem, try again.."
      render 'new'
    end
  end
  def update

  end
  def destroy

  end
end
