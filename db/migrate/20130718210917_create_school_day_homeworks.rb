class CreateSchoolDayHomeworks < ActiveRecord::Migration
  def change
    create_table :school_day_homeworks do |t|
    	t.integer :school_day_id
    	t.integer :homework_id

      t.timestamps
    end
  end
end
