class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: session_params[:username])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "logged in: #{@user.username}"
      redirect_to root_path
    else
      flash[:notice] = "login failed"
      redirect_to root_path
    end
  end

  def update
  end

  def destroy
  end

  private

  def session_params
    params.require(:sessions).permit(:username, :password)
  end
end
