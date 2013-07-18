class CreateSchoolDayLabs < ActiveRecord::Migration
  def change
    create_table :school_day_labs do |t|
      t.integer  :school_day_id
      t.integer  :lab_id

      t.timestamps
    end
  end
end
