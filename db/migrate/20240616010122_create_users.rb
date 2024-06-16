# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.text :password_digest
      t.boolean :active, default: false
      t.boolean :admin, default: false
      t.timestamps
    end
  end
end
