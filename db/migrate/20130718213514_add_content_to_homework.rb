class AddContentToHomework < ActiveRecord::Migration
  def change
    add_column :homeworks, :content, :text
  end
end
