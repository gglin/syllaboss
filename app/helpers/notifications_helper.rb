module NotificationsHelper

  # if student, only load resources for closest day before today
  def load_unread_resources
    @unread = []
    material_type_list.each do |material_hash|
      material_type = material_hash[:name]
      if material_type != "school_day"
        unread_materials = material_type.classify.constantize.unread_by(current_user)
        if current_user.admin?
          filtered_unread_materials = unread_materials
        else
          filtered_unread_materials = unread_materials.select do |material| 
            !material.school_days.empty? && !material.school_days.nil? && material.school_days.include?(closest_day_before_today)
          end
        end
        @unread += filtered_unread_materials
      end
    end
    @unread.sort_by!(&:updated_at).reverse!
  end

  # when in unread view, load all resources
  # for students, hide unassociated resources and resources in the future
  def load_all_unread
    @all_unread = []
    material_type_list.each do |material_hash|
      material_type = material_hash[:name]
      if material_type != "school_day"
        unread_materials = material_type.classify.constantize.unread_by(current_user)
        if current_user.admin?
          filtered_unread_materials = unread_materials
        else
          filtered_unread_materials = unread_materials.select do |material| 
            !material.school_days.empty? && !material.school_days.nil? && material.school_days.order("calendar_date")[0].calendar_date <= Date.today
          end
        end
        @all_unread += filtered_unread_materials
      end
    end
    @all_unread.sort_by!(&:updated_at).reverse!
  end

  # for students, hide comments linked to unassociated resources and resources in the future
  def load_unread_comments
    @unread_comments = Comment.unread_by(current_user)
    if current_user.student?
      @unread_comments = @unread_comments.select do |comment| 
        comment_parent      = comment.commentable_type.classify.constantize.find(comment.commentable_id)
        comment_parent_type = comment.commentable_type.underscore
        if comment_parent_type == "school_day"
          comment_parent.calendar_date <= Date.today
        else
          comment_parent.school_days.order("calendar_date")[0].calendar_date <= Date.today if !comment_parent.school_days.empty?
        end
      end
    end
    @unread_comments.sort_by!(&:created_at).reverse!
  end

end
