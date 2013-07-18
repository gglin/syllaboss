class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.integer :creator
      t.string :title
      t.text :content
      t.string :file_upload

      t.timestamps
    end
  end
end
