class CreateSchoolDayLectures < ActiveRecord::Migration
  def change
    create_table :school_day_lectures do |t|
      t.integer :school_day_id
      t.integer :lecture_id

      t.timestamps
    end
  end
end
