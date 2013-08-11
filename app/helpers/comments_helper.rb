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

  def default_value_for(comment)
    replied = comment.user==current_user ? "" : "@#{comment.user.full_name}"
    all_matched_names = comment.content.scan(all_user_name_patterns).flatten
    all_matched_names.unshift(replied).uniq!
    
    default_value = all_matched_names.delete_if { |name| name =~ /@#{current_user.full_name}/ }.join(" ")
    default_value.strip! if default_value
    default_value.gsub!(/\s+/, " ") if default_value
    default_value += "  " unless default_value.empty? || default_value.nil?
  end

end
