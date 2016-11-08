class AddTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_type, :string, default: 'normal'
  end
end
