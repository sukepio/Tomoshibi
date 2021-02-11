class AddResidentIdToMyevents < ActiveRecord::Migration[5.2]
  def change
    add_column :myevents, :resident_id, :integer
  end
end
