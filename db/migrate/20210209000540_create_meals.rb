class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.string :menu
      t.integer :amount
      t.string :detail
      t.datetime :start

      t.timestamps
    end
  end
end
