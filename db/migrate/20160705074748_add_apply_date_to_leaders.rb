class AddApplyDateToLeaders < ActiveRecord::Migration
  def change
    add_column :leaders, :apply_date, :datetime
  end
end
