class FixSpellingMissOfDefalutOnResident < ActiveRecord::Migration[5.2]
  def up
    change_column :residents, :has_left, :boolean, null: false, default: false
    change_column :residents, :photo_accepted, :boolean, null: false, default: false
  end
  
  def down
    change_column :residents, :has_left, :boolean, null: false, defalut: false
    change_column :residents, :photo_accepted, :boolean, null: false, defalut: false
  end
end
