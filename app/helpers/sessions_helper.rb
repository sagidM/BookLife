module SessionsHelper
  def sign_in(user, remember=false)
    cook = remember ? cookies.persistent : cookies
    cook[:user_id] = user.id
    token = User.encrypt(cook[:remember_token] = User.generate_unique_secure_token)
    session = Session.new remember_token: token, ip_address: request.remote_ip, user: user
    session.save!
    @current_session = session
  end

  def sign_out
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def current_session
    if @current_session.nil?
      uid, token = cookies[:user_id], cookies[:remember_token]
      return if uid.nil? or token.nil?

      session = Session.eager_load(:user).find_by user_id: uid, remember_token: User.encrypt(token)
      if session.nil?
        delete_session_cookies
        p 'session is deleted'
      end
      @current_session = session
    end
    @current_session
  end

  def current_user
    current_session ? current_session.user : nil
  end

  def signed_in?
    !!current_session
  end

  private
    def current_user=(user)
      @current_user = user
    end
    def delete_session_cookies
      cookies.delete :user_id
      cookies.delete :remember_token
    end
end
