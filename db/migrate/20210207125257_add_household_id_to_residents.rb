class AddHouseholdIdToResidents < ActiveRecord::Migration[5.2]
  def change
    add_column :residents, :household_id, :integer
  end
end
