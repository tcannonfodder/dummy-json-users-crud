class AddNotesAndStatusToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.text :notes
      t.integer :status, length: 1, default: 0
    end
  end
end
