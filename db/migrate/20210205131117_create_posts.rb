class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :admin_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.string :image_id

      t.timestamps
    end
    add_index :posts, :title
  end
end
