class CommentsController < ApplicationController

  before_filter :load_commentable, :except => [:index]
  
  authorize_resource
  
  def index
    @new_comment = Comment.new

    if current_user.admin?
      @comments = Comment.order("created_at DESC")
    else
      @comments = Comment.order("created_at DESC").select do |comment|
        comment_parent      = comment.commentable_type.classify.constantize.find(comment.commentable_id)
        comment_parent_type = comment.commentable_type.underscore

        if comment_parent_type == "school_day"
          comment_parent.calendar_date <= Date.today
        else
          comment_parent.school_days.order("calendar_date")[0].calendar_date <= Date.today if !comment_parent.school_days.empty?
        end
      end
    end
    
    @comments.each do |comment|
      comment.mark_as_read! :for => current_user
    end
  end

  def create
    @comment = @commentable.comments.new(params[:comment])

    if @comment.save
      if request.referrer.split('/').last == "comments"
        redirect_to comments_path, notice: "Comment posted."
      else
        redirect_to self.send("#{@commentable_type}_path", @commentable) + "#comment-#{@comment.id}", notice: "Comment posted."
      end
    else
      render :index
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(params[:comment])
      if request.referrer.split('/').last == "comments"
        redirect_to comments_path + "#comment-#{@comment.id}", notice: "Comment edited."
      else
        redirect_to self.send("#{@commentable_type}_path", @commentable) + "#comment-#{@comment.id}", notice: "Comment edited."
      end
    else
      render :index
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: "Comment deleted." }
      format.json { head :no_content }
    end
  end

private
  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    if resource != "comments" && id 
      @commentable = resource.singularize.classify.constantize.find(id)
      @commentable_type = resource.singularize.underscore
    else
      @commentable = closest_day_before_today
      @commentable_type = "school_day"
    end
  end
end