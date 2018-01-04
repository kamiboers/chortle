class UsersController < ApplicationController
  def create
    if (user_params[:password] == user_params[:password_confirmation])
      @user = User.new(username: user_params[:username], password: user_params[:password])
      if @user.save
        flash[:notice] = "new account: #{@user.username}"
      else
        flash[:notice] = "account creation failed"
      end

      redirect_to root_path
    else
      flash[:notice]
      redirect_to root_path
    end
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:users).permit(:username, :password, :password_confirmation)
  end
end
