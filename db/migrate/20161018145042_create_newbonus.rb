class CreateNewbonus < ActiveRecord::Migration
  def change
    create_table :newbonus do |t|
      t.integer :user_id
      t.decimal :bonus, precision: 12, scale: 2, default: 0

      t.timestamps null: false
    end
  end
end
