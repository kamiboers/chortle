class SessionsController < ApplicationController
  
  def create
    @user = User.find_by(username: session_params[:username].downcase)
    if user && user.authenticate(session_params[:password])
      log_in(user)
      store_session_token(user)
      redirect_with_message(root_path, "logged in: #{user.username}", :success)
    else
      redirect_with_message(root_path, "login failed", :warning)
    end
  end

  def destroy
    log_out(user)
    redirect_with_message(root_path, "logout successful", :success)
  end

  private

  attr_reader :user

  def session_params
    params.require(:session).permit(:username, :password)
  end

  def redirect_with_message(path, message, message_type = :notice)
    flash[message_type] = message
    redirect_to root_path
  end
end
