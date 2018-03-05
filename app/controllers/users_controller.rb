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
    @user = User.find_by(id: user_params[:id])
    if user && user.update_attributes(user_params)
      flash[:notice] = "user updated successfully"
    else
      flash[:notice] = "unable to update user: #{user.errors.messages}"
    end
    redirect_to root_path
  end

  def destroy
    @user = User.find_by(id: user_params[:id])
    if user && user.destroy
      flash[:notice] = "user account deleted"
      redirect_to logout_path
    else
      flash[:notice] = "unable to delete user account"
      redirect_to root_path
    end
  end

  private

  attr_reader :user

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :id)
  end
end
