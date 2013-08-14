class SchoolDay < ActiveRecord::Base
  attr_accessible :calendar_date_string, :ordinal, :schedule, :week, :links, :links_attributes, :comment_ids
  attr_accessible :potd_id, :link_ids, :lecture_ids, :todo_ids, :lab_ids, :homework_ids

  belongs_to :potd

  has_many :school_day_links
  has_many :links, :through => :school_day_links

  has_many :school_day_todos
  has_many :todos, :through => :school_day_todos

  has_many :school_day_labs
  has_many :labs, :through => :school_day_labs

  has_many :school_day_homeworks
  has_many :homeworks, :through => :school_day_homeworks

  has_many :school_day_lectures
  has_many :lectures, :through => :school_day_lectures

  has_many :comments, as: :commentable

  searchable do
    text :schedule, :links, :potd_id
  end  

  # validates_uniqueness_of :ordinal, :calendar_date

  validates :ordinal, :week, :calendar_date, :presence => true
  # validates :ordinal, :inclusion => { :in => 1..65, :message => "must be between 1 and 65" }
  # validates :ordinal, uniqueness: {case_sensitive: false, :message => "That day already exists." }
  # validates :week, :inclusion => { :in => 1..11, :message => "must be between 1 and 11" }
  # validates :calendar_date, :date => { :before => Time.now, :message => "You can't select dates in the past." }
 
  # validates_format_of :schedule, :with =>/\d{1,2}\W{1}\d{2}.*\s*[-]\s*\d{1,2}\W{1}\d{2}.*/ , :on => :create, :message=>"You must format times as X:XX - XX:XX, for example, 9:45 - 11:30"
  
  def print_name
    ordinal
  end

  def schedulize
    return [{:time => "", :stuff => ""}] if schedule.nil?

    # split all rows by time
    output1 = self.schedule.split("\n").compact
    output2 = output1.collect do |row|
      # format time
      row0 = row.slice!(/^[\d:]+(AM|PM|am|pm)?\s*\-\s*[\d:]+(AM|PM|am|pm)?/) # start_time - end_time
      row0 = row0[0..-2] if !row0.nil? && row0[-1] == ":"

      # find stuff
      row.slice!(/^(\s?\-|:?)/)
      
      if !row0.nil?
        {:time => row0, :stuff => row}
      else
        {:time => "", :stuff => row}
      end
    end

    # aggregate rows without times into the last row that has a time (or the first row)
    output2.each_with_index do |row, index|   
      if row[:time] != "" || index == 0
        @row_with_time = row
      elsif !@row_with_time.nil? && row[:time] == "" && !row.nil?
        @row_with_time[:stuff] << " #{row[:stuff]}"
      end
    end

    # delete empty rows
    output2.delete_if.with_index {|row, index| index != 0 && row[:time].empty?}
  end

  def print_search
    #[ordinal, calendar_date, schedule]
    schedule
  end


  def calendar_date_string
    calendar_date.to_s
  end

  def calendar_date_string=(calendar_date_str)
    self.calendar_date = Date.parse(calendar_date_str)
  rescue ArgumentError
    @calendar_date_invalid = true
  end

  def validate
    errors.add(:calendar_date, "is invalid") if @calendar_date_invalid
  end
end

