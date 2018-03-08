class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "new account: #{user.username}"
    else
      flash[:warning] = "account creation failed: #{user.errors.full_messages.join(', ')}"
    end
    redirect_to root_path
  end

  def update
    @user = User.find_by(id: user_params[:id])
    if user && user.update_attributes(user_params)
      flash[:success] = "user updated successfully"
    else
      flash[:warning] = "unable to update user: #{user.errors.full_messages.join(', ')}"
    end
    redirect_to root_path
  end

  def destroy
    @user = User.find_by(id: user_params[:id])
    if user && user.destroy
      flash[:success] = "user account deleted"
      redirect_to logout_path
    else
      flash[:warning] = "unable to delete user account"
      redirect_to root_path
    end
  end

  private

  attr_reader :user

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :id)
  end
end
