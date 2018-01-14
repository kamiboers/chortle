class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: session_params[:username])
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash[:notice] = "logged in: #{user.username}"
      redirect_to root_path
    else
      flash[:notice] = "login failed"
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  attr_reader :user

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
