p 'users_controller initialize'
# fdssda
class UsersController < ApplicationController
  before_action :signed_in, only: [:edit_current_user]

  def index
    @users = User.all
  end
  def new
    @user = User.new
  end

  def edit
  end

  def edit_current_user
    @user = current_user
  end

  def update_current_user
    params_user.delete :password
    current_user.update_columns params_user.to_h
    redirect_to action: :edit_current_user
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
      params.require(:user).permit :email, :password, :first_name, :surname, :bdate
    end
    def signed_in
      unless signed_in?
        flash[:error] = 'Not authenticated'
        redirect_to signin_path
      end
    end
end
