module CommentsHelper
  
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

end
