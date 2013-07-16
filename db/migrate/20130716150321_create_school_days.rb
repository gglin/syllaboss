class CreateSchoolDays < ActiveRecord::Migration
  def change
    create_table :school_days do |t|
      t.integer :ordinal
      t.date :calendar_date
      t.text :schedule
      t.integer :week

      t.timestamps
    end
  end
end
