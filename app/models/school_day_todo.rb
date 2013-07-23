class SchoolDayTodo < ActiveRecord::Base
  attr_accessible :todo_id, :school_day_id, :todo

  belongs_to :todo
  belongs_to :school_day
end
