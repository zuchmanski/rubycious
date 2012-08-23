class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :admin?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin?
    current_user && current_user.admin?
  end

  def user_area
    unless current_user
      flash[:notice] = "Please, log in."
      redirect_to root_path
    end
  end

  def admin_area
    unless admin?
      flash[:notice] = "Admin area."
      redirect_to root_path
    end
  end
end
