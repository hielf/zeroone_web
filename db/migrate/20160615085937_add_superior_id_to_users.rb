class AddSuperiorIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :superior_id, :integer
  end
end
