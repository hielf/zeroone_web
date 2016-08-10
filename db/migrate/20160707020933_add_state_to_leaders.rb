class AddStateToLeaders < ActiveRecord::Migration
  def change
    add_column :leaders, :state, :string
    add_column :leaders, :loan_state, :string
  end
end
