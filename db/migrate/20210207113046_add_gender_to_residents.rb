class AddGenderToResidents < ActiveRecord::Migration[5.2]
  def change
    add_column :residents, :gender, :boolean, null: false, default: 0
  end
end
