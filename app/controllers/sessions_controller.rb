class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  def create
    user = User.find_by_email params[:user][:email]

    if user.nil?
      flash[:signin_error] = :email_not_found
    elsif !user.authenticate params[:user][:password]
      flash[:signin_error] = :wrong_password
    else
      redirect_to redirect_or_default_path
      sign_in user, params[:user][:remember]
      return
    end
    @user = User.new
    render :new
  end
  def destroy
    sign_out
    redirect_to redirect_or_default_path
  end
end
