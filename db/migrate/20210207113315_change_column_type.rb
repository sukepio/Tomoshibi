class ChangeColumnType < ActiveRecord::Migration[5.2]
  def up
    change_column :residents, :gender, :integer, null: false, default: 0
  end
  
  def down
    change_column :residents, :gender, :boolean, null: false, default: false
  end
end
