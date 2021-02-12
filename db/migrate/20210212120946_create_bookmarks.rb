class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.integer :resident_id
      t.integer :post_id

      t.timestamps
    end
  end
end
