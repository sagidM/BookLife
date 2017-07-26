class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new params_user
    if @user.save
      sign_in @user, params[:user][:remember]
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    user = User.find params[:user][:id]
    user.destroy
    redirect_to root_path
  end

  private
    def params_user
      params.require('user').permit :email, :password, :first_name, :surname, :bdate
    end
end
