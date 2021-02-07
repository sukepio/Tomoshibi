class RemoveNullFromSomeColumns < ActiveRecord::Migration[5.2]
  def up
    change_column :residents, :household_id, :integer
    change_column :households, :head_id, :integer
  end
  
  def down
    change_column :residents, :household_id, :integer, null: false
    change_column :households, :head_id, :integer, null: false
  end
end
