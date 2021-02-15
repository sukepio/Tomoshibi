class RemoveColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :residents, :household_id, :integer, null: false
  end
end
