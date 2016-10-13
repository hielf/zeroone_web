class AddBonusToRecords < ActiveRecord::Migration
  def change
    add_column :records, :bonus, :decimal, precision: 12, scale: 2, default: 0
    add_column :records, :commis, :decimal, precision: 12, scale: 2, default: 0
  end
end
