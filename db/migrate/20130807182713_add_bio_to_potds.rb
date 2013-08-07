class AddBioToPotds < ActiveRecord::Migration
  def change
    add_column :potds, :bio, :text
  end
end
