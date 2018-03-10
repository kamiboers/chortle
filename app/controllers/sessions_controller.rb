class SessionsController < ApplicationController
  
  def create
    @user = User.find_by(username: session_params[:username].downcase)
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash[:success] = "logged in: #{user.username}"
      redirect_to root_path
    else
      flash[:warning] = "login failed"
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    flash[:success] = "logout successful"
    redirect_to root_path
  end

  private

  attr_reader :user

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
