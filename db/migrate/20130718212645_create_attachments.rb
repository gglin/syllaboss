class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :title
      t.string :filename

      # t.belongs_to :attachable, polymorphic: true
      #    above line is same as below
      t.integer :attachable_id
      t.string :attachable_type

      t.timestamps
    end
    add_index :attachments, [:attachable_id, :attachable_type]
  end
end
