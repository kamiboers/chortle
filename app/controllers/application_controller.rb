class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  include SessionsHelper

  def authorize
    # redirect_to '/login' unless current_user
  end
end
