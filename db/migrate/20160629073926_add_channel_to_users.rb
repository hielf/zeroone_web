class AddChannelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :channel, :string, default: '001'
  end
end
