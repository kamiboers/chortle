class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:notice] = "new account: #{user.username}"
    else
      flash[:notice] = "account creation failed: #{user.errors.messages}"
    end
    redirect_to root_path
  end

  def update
  end

  def destroy
  end

  private

  attr_reader :user

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
