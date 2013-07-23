class UsersController < ApplicationController

  def index
    @users = User.all
    authorize! :index, @users
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.set_as_student
    if @user.save
      session[:user_id]= @user.id
      redirect_to root_url, notice: "Thanks for signing up!"
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  @user = User.find(params[:id])

  respond_to do |format|
    if @user.update_attributes(params[:user])
      format.html { redirect_to "/users", notice: 'User was successfully updated.' }
      format.json { head :no_content }
    else
      format.html { render action: "edit" }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
    end
  end
end
