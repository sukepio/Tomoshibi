class AddAmountToMeals < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :amount, :integer
  end
end
