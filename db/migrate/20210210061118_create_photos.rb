class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.integer :resident_id, null: false
      t.string :images, null: false

      t.timestamps
    end
  end
end
