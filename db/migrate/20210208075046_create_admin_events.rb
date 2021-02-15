class CreateAdminEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_events do |t|
      t.string :title
      t.string :body
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
