class SchoolDayTodo < ActiveRecord::Base
  attr_accessible :school_day_id, :todo_id

  belongs_to :todo
  belongs_to :school_day
end
