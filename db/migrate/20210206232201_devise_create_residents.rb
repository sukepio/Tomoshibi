# frozen_string_literal: true

class DeviseCreateResidents < ActiveRecord::Migration[5.2]
  def change
    create_table :residents do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at
      t.integer :household_id, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :first_name_kana, null: false
      t.string :last_name_kana, null: false
      t.date :date_of_birth, null: false
      t.string :phone_number, null: false
      t.string :login_id, null: false
      t.boolean :has_left, null: false, defalut: false
      t.string :self_message, default: 'みなさんの支えに感謝！'
      t.text :information
      t.boolean :photo_accepted, null: false, defalut: false
      

      t.timestamps null: false
    end

    add_index :residents, :first_name
    add_index :residents, :last_name
    add_index :residents, :first_name_kana
    add_index :residents, :last_name_kana
    add_index :residents, :reset_password_token, unique: true
    # add_index :residents, :confirmation_token,   unique: true
    # add_index :residents, :unlock_token,         unique: true
  end
end
