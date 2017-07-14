class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      flash[:sign_in] = "#{ user.name } signed in"
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/sign_in'
    end
  end

  def destroy
    user = current_user
    session[:user_id] = nil
    flash[:sign_out] = "#{ user.name } signed out"
    redirect_to '/sign_in'
  end

end
