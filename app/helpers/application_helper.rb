module ApplicationHelper

  def material_capitalize(material_type)
    if material_type == "potd"
      "POTD"
    elsif material_type == "todo"
      "To-Do"
    elsif material_type == "school_day"
      "Day"
    else
      material_type.capitalize
    end
  end

  def re_truncate(text, options={}, max_lines=8, &block)
    if !text.nil?
      new_text = text.split("\n")[0..max_lines].join("\n")
      new_text += "..." if new_text != text
      truncate(new_text, options, &block)
    else
      " "
    end
  end

  def material_type_list
    [
      {name: "school_day",  icon: "calendar"}, 
      {name: "lecture",     icon: "folder-open"}, 
      {name: "todo",        icon: "edit"}, 
      {name: "potd",        icon: "user"}, 
      {name: "lab",         icon: "laptop"}, 
      {name: "link",        icon: "link"}, 
      {name: "homework",    icon: "book"}
    ]
  end

  def label_type(type)
    case type
    when "SchoolDay" then ""               
    when "Lecture"   then "label-info"     
    when "Homework"  then "label-success"  
    when "Potd"      then "label-primary"  
    when "Todo"      then "label-success"  
    when "Link"      then "label-info"     
    when "Lab"       then "label-success"  
    else                  ""               
    end
  end

  def title(page_title)
    content_for(:title){page_title}
  end

  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end

end
