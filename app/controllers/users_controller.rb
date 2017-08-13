class UsersController < ApplicationController
  before_action :signed_in, only: [:edit_current_user]

  def index
    @users = User.paginate page: params[:page], per_page: 10
  end
  def new
    @user = User.new
  end

  def show
    @user = User.find params[:id]
  end

  def edit
  end

  def edit_current_user
    @user = current_user
  end

  def update_current_user
    user_fields = user_params
    user_fields.delete :password_digest
    user_fields.delete :created_at

    new_avatar = params[:user][:avatar]
    old_avatar = nil
    unless new_avatar.nil?
      if new_avatar.size > 10.megabyte
        flash[:image] = 'image is too big'
        redirect_to action: :edit_current_user
        return
      end
      user_fields[:avatar] = new_avatar.original_filename
      old_avatar = current_user.avatar  # never nil
    end
    # if params[:user][:remote_avatar_url]
    #   p params[:user][:remote_avatar_url]
    #   current_user.avatar = params[:user][:remote_avatar_url]
    #   current_user.avatar.store!
    #   redirect_to action: :edit_current_user
    #   return
    # end

    ActiveRecord::Base.transaction do
      current_user.update_columns user_fields.merge(updated_at: Time.now).to_h
      if old_avatar
        old_avatar.remove!
        current_user.avatar = new_avatar
        current_user.avatar.store!
      end
    end
    redirect_to action: :edit_current_user
  end

  def find
    count = params[:count]
    user_hash = params.require(:user).permit(:email, :first_name, :surname, :bdate)

    if count.nil?
      json = User.find_by(user_hash)
    else
      json = User.limit(count).where(user_hash)
    end
    render json: json.as_json(methods: :image, except: :password_digest)
  end

  def create
    @user = User.new user_params
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
    def user_params
      params.require(:user).permit :email, :password, :first_name, :surname, :bdate
    end
    def signed_in
      unless signed_in?
        flash[:message] = 'You\'re not authenticated'
        redirect_to signin_path(request.path)
      end
    end
end
