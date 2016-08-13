class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :user_id
      t.integer :product_id
      t.date :sell_date
      t.decimal :qty, precision: 12, scale: 2, default: 0
      t.decimal :total_prize, precision: 12, scale: 2, default: 0
      t.string :customer_name
      t.string :customer_cell
      t.string :status

      t.timestamps null: false
    end
  end
end
