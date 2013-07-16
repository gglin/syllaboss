class CreatePotds < ActiveRecord::Migration
  def change
    create_table :potds do |t|
      t.string :name
      t.string :wikipedia
      t.string :presentation_url

      t.timestamps
    end
  end
end
