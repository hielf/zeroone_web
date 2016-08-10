class AddCommissionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :commission, :decimal, precision: 12, scale: 2, default: 0
    add_column :users, :second_commission, :decimal, precision: 12, scale: 2, default: 0
    add_column :users, :third_commission, :decimal, precision: 12, scale: 2, default: 0
    add_column :users, :balance, :decimal, precision: 12, scale: 2, default: 0
  end
end
