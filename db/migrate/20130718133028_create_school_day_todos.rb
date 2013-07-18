class CreateSchoolDayTodos < ActiveRecord::Migration
  def change
    create_table :school_day_todos do |t|
      t.integer :todo_id
      t.integer :school_day_id

      t.timestamps
    end
  end
end
