class ChangeSecondToCarousels < ActiveRecord::Migration
  def change
    change_column :carousels, :second, :string, :limit => 2000
  end
end
