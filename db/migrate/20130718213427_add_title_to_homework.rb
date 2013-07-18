class AddTitleToHomework < ActiveRecord::Migration
  def change
    add_column :homeworks, :title, :string
  end
end
