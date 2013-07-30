class CommentsController < ApplicationController

  before_filter :load_commentable, :except => [:index]
  authorize_resource
  
  def index
    @comments = Comment.order("created_at DESC")
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    if @comment.save
      redirect_to @commentable, notice: "Comment posted."
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end


private
  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    if resource != "comments" && id 
      @commentable = resource.singularize.classify.constantize.find(id)
    else
      @commentable = closest_day_to_today
    end
  end
end