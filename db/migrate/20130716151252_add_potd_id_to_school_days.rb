class AddPotdIdToSchoolDays < ActiveRecord::Migration
  def change
    add_column :school_days, :potd_id, :integer
  end
end
