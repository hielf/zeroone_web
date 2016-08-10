class AddAmountToLeaders < ActiveRecord::Migration
  def change
    add_column :leaders, :amount, :decimal, precision: 12, scale: 2, default: 0
  end
end
