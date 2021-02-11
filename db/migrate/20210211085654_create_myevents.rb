class CreateMyevents < ActiveRecord::Migration[5.2]
  def change
    create_table :myevents do |t|
      t.string :title, null: false
      t.string :body
      t.datetime :start, null: 

      t.timestamps
    end
  end
end
