class SessionsController < ApplicationController

  skip_before_filter :authenticate, :only => [:new, :create]
  skip_before_filter :load_unread_resources, :only => [:new, :create]
  skip_before_filter :load_all_unread,       :only => [:new, :create]
  skip_before_filter :load_unread_comments,  :only => [:new, :create]
  skip_before_filter :load_announcements,    :only => [:new, :create]
  # skip_after_filter  :mark_announcements_as_read

  def new
    @user = User.new
    @view_signup = false
    render :layout => "landing"
  end

  def create 
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      @user = User.new
      @view_signup = false
      flash[:error] = "Email or Password is invalid"
      render "new", :layout => "landing"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out"
    #reset_session
  end
end
