class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
      @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Your profile updated'
      redirect_to user_path #redirect to user/show page like user/:id
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    if @user.save
      flash[:success] = "Welcome #{@user.name}"
      redirect_to @user #redirect to user/show page like user/:id
    else
      flash.now[:error] = 'Sorry there was problem with sign up, try again...'
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = "User Deleted.."
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def signed_in_user
      unless signed_in?
        store_location #user are not logged in than it store url location into session key return_to
        redirect_to signin_path, notice: 'Please Signin'
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to current_user unless current_user?(@user)
    end
end
