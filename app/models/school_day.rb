class SchoolDay < ActiveRecord::Base
  attr_accessible :calendar_date, :ordinal, :schedule, :week, :links, :potd_id, :links_attributes, :comment_ids

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
  
  # validates_uniqueness_of :ordinal, :calendar_date
  validates :ordinal, :week, :calendar_date, :presence => true

  accepts_nested_attributes_for :links

  def schedulize
    return [{:time => "", :stuff => ""}] if schedule.nil?
    output = self.schedule.split("\n").delete_if{|line| line.empty? || line == "\r" || line =~ /^\s+$/ }.compact
    output.collect do |row|
      row = row.split(/:\s+/,2)
      if row.size == 2
        {:time => row[0], :stuff => row[1]}
      else
        {:time => "", :stuff => row[0]}
      end
    end
  end

end

