class RemoveHeadIdFromHouseholds < ActiveRecord::Migration[5.2]
  def change
    remove_column :households, :head_id, :integer
  end
end
