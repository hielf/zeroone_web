class AddSubordinateIdToNewbonus < ActiveRecord::Migration
  def change
    add_column :newbonus, :subordinate_id, :integer
  end
end
