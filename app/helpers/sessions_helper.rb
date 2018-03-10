module SessionsHelper
  
  def log_in(user)
    session[:user_id] = user.id
  end

  def store_session_token(user)
    user.set_session_token
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:session_token] = user.session_token
  end

  def log_out(user)
    session[:user_id] = nil
    @current_user = nil
  end
end
