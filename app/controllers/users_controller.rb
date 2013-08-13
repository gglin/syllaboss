class UsersController < ApplicationController

  load_and_authorize_resource
  skip_before_filter :authenticate, :only => [:new, :create]
  skip_before_filter :load_unread_resources, :only => [:create]
  skip_before_filter :load_all_unread,       :only => [:create]
  skip_before_filter :load_unread_comments,  :only => [:create]
  skip_before_filter :load_announcements,    :only => [:create]
  # skip_after_filter  :mark_announcements_as_read,    :only => [:new, :create]

  def index
    @users = User.order("role DESC, full_name")
    # authorize! :index, @users
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    @comments = filter_comments(Comment.where("user_id = ?", @user.id).order("created_at DESC"))
    @comment = Comment.new

    @comments.each do |comment|
      comment.mark_as_read! :for => current_user
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def create
    @user = User.new(params[:user])
    @user.set_as_student
    if @user.save
      session[:user_id]= @user.id
      redirect_to root_url, notice: "Thanks for signing up!"
    else
      @view_signup = true
      flash[:error] = "There were errors signing up."
      render "sessions/new", :layout => "landing"
    end
  end

  def edit
    @user = User.find(params[:id])
    # authorize! :edit, @user
  end

  def update
    @user = User.find(params[:id])
    # authorize! :update, @user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully deleted." }
      format.json { head :no_content }
    end
  end
end
