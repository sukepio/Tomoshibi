class RemoveDefaultValueFromHouseholdId < ActiveRecord::Migration[5.2]
  def up
    change_column :residents, :household_id, :integer
  end
  
  def donw
    change_column :residents, :household_id, :integer, default: 1    
  end
end
