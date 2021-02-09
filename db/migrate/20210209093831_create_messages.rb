class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.string :image
      t.string :sender, null: 

      t.timestamps
    end
  end
end
