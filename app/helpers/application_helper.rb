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

  def re_truncate(text, options={}, max_lines=8, &block)
    if !text.nil?
      new_text = text.split("\n")[0..max_lines].join("\n")
      new_text += "..." if new_text != text
      truncate(new_text, options, &block)
    else
      " "
    end
  end

  def title(page_title)
    content_for(:title){page_title}
  end

  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end

  def cancel_path_for(material)
    material_type  = material.class.to_s.underscore
    material_types = material_type.pluralize

    if @from_preview
      material.persisted?  ?  self.send("#{material_type}_preview_path", material) : :back
    else
      if params[:day].nil? || params[:day].empty?
        material.persisted?  ?  self.send("#{material_type}_path", material) : :back
      else
        if params[:day].empty?
          new_school_day_path + "##{material_types}"
        else
          edit_school_day_path(SchoolDay.find(params[:day])) + "##{material_types}"
        end
      end
    end
  end

  def link_to_add_fields(name, f, association, add_more_classes = "")
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render("layouts/" + association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields #{add_more_classes}", data: {id: id, fields: fields.gsub("\n", "")})
  end


  # customize simple_format method from Rails
  #    spaces between paragraphs are preserved
  #    formatting between <pre></pre> tags is preserved
  #    leading white spaces are preserved
  #       (http://www.pressingquestion.com/2955403/Convert-Leading-Spaces-To-Tabs-In-Ruby)
  #    @username (Twitter style) is autolinked
  def better_format(text, html_options = {}, options = {})
    wrapper_tag = options.fetch(:wrapper_tag, :p)

    text = sanitize(text) if options.fetch(:sanitize, true)
    paragraphs = split_paragraphs(text)

    if paragraphs.empty?
      content_tag(wrapper_tag, nil, html_options)
    else
      paragraphs.map { |paragraph|
        # paragraph = "<br />" if paragraph.empty? || paragraph =~ /\A\s+\z/ 
        paragraph.gsub!(/(?:^\s)|\G\s/m, "&nbsp;") if !(paragraph[0..4]=="<pre>" && paragraph[-6..-1]=="</pre>")
        content_tag(wrapper_tag, paragraph, html_options, options[:sanitize])
      }.join("\n\n").html_safe
    end
  end


  def all_user_names
    User.all.map(&:full_name)
  end

  def all_user_name_patterns
    str = all_user_names.map{|name| "(@#{name})"}.join("|")
    Regexp.new str
  end


private

  def insert_at_user(text)
    return "" if text.blank?

    texts_between_usernames = text.scan(all_user_name_patterns).flatten

    text.split(all_user_name_patterns).map do |subtext|
      if texts_between_usernames.include?(subtext)
        name = subtext[1..-1]
        user = User.where("full_name = ?", name).first
        link_to "@#{name}", user_path(user.id) 
      else
        subtext
      end
    end.flatten.join()
  end

  def pattern_between(text)
    /<#{text}>(.+?)<\/#{text}>/m
  end

  def split_paragraphs(text)
    return [] if text.blank?

    pre = pattern_between("pre")
    texts_between_pre = text.scan(pre).flatten

    text.split(pre).map do |subtext|
      if texts_between_pre.include?(subtext)
        "<pre>#{subtext}</pre>"
      else
        subt = subtext.to_str.gsub(/\r\n?/, "\n").gsub(/\n\n+/, "<br>\n\n").split(/\n\n/).map! do |t|
          t.gsub(/([^\n]\n)(?=[^\n])/, '\1<br/>') || t
        end
        subt.map { |text| insert_at_user(text)  }
      end
    end.compact.flatten
  end

end
