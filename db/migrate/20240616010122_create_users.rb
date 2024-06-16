class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true, null: false, index: true
      t.string :password_digest, unique: true, null: false
      t.boolean :active, default: false
      t.timestamps
    end
  end
end
