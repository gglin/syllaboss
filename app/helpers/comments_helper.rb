module CommentsHelper

  def filter_comments(comments)
    if current_user.admin?
      comments
    else
      comments_before_today(comments)
    end
  end

  def comments_before_today(comments)
    comments.select do |comment|
      comment_parent      = comment.commentable_type.classify.constantize.find(comment.commentable_id)
      comment_parent_type = comment.commentable_type.underscore

      if comment_parent_type == "school_day"
        comment_parent.calendar_date <= Date.today
      else
        comment_parent.school_days.order("calendar_date")[0].calendar_date <= Date.today if !comment_parent.school_days.empty?
      end
    end
  end

end
