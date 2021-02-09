class RemoveAmountFromMeals < ActiveRecord::Migration[5.2]
  def change
    remove_column :meals, :amount, :integer
  end
end
