class MoreFieldsToLeaders < ActiveRecord::Migration
  def change
    add_column :leaders, :approve_time, :datetime
    add_column :leaders, :approve_amount, :decimal, precision: 12, scale: 2, default: 0.0
    add_column :leaders, :commission, :decimal, precision: 12, scale: 2, default: 0.0
    add_column :leaders, :second_commission, :decimal, precision: 12, scale: 2, default: 0.0
    add_column :leaders, :third_commission, :decimal, precision: 12, scale: 2, default: 0.0
  end
end
