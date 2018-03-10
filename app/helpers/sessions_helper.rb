module SessionsHelper

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  def log_in(user)
    session[:user_id] = user.id
  end

  def store_session_token(user)
    user.set_session_token
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:session_token] = user.session_token
  end

  def log_out(user)
    clear_cookies(current_user)
    session[:user_id] = nil
    @current_user = nil
  end

  def clear_cookies(user)
    user.clear_session_token
    cookies.delete(:user_id)
    cookies.delete(:session_token)
  end

end
