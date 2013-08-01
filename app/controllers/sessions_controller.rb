class SessionsController < ApplicationController
  skip_before_filter :authenticate, :only => [:new, :create]

  def new
    render :layout => false
  end

  def create 
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash[:notice] = "Email or password is invalid"
      render "new", :layout => false
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_user_path, notice: "Logged out"
    #reset_session
  end
end
