class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :dummy_json_id, null: false
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email
      t.string :domain
      t.string :ip_address
      t.string :mac_address
      t.text :user_agent

      t.timestamps
      t.index [:email]
      t.index [:dummy_json_id], unique: true
    end
  end
end
