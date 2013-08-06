module NotificationsHelper
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
end
