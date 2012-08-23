class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    if user = (User.where(:uid => auth["uid"]).first || User.create_with_omniauth(auth))
      session[:user_id] = user.id
      flash[:notice] = "Successfully signed in."
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Successfully signed out."
    redirect_to root_url
  end

end