class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :link_url
      t.text :description

      t.timestamps
    end
  end
end
