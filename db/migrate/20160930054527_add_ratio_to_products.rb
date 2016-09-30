class AddRatioToProducts < ActiveRecord::Migration
  def change
    add_column :products, :ratio, :decimal, precision: 12, scale: 2, default: 0
    add_column :products, :bonus, :decimal, precision: 12, scale: 2, default: 0
  end
end
