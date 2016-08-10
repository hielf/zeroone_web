class AddChannelToLeaders < ActiveRecord::Migration
  def change
    add_column :leaders, :channel, :string
  end
end
