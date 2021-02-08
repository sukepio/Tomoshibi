class CreateHouseholds < ActiveRecord::Migration[5.2]
  def change
    create_table :households do |t|
      t.integer :head_id, null: false
      t.string :living_space, null: false, default: 'A-1'
      t.string :address, null: false
      t.string :house_damage_situation, null: false

      t.timestamps
    end

  end
end
