class AddColumnsToHouseholds < ActiveRecord::Migration[5.2]
  def change
    add_column :households, :head_last_name, :string
    add_column :households, :head_first_name, :string
  end
end
