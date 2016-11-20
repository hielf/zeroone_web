class AddUserInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :id_card, :string
    add_column :users, :bank_card, :string
  end
end
