class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :day_number
      t.date :day_date
      t.text :schedule
      t.integer :week

      t.timestamps
    end
  end
end
