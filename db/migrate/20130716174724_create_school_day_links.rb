class CreateSchoolDayLinks < ActiveRecord::Migration
  def change
    create_table :school_day_links do |t|
      t.integer :school_day_id
      t.integer :link_id

      t.timestamps
    end
  end
end
