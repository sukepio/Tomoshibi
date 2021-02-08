class RemoveHouseholdIdFromResidents2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :residents, :household_id, :integer
  end
end
