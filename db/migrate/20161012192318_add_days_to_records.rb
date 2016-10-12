class AddDaysToRecords < ActiveRecord::Migration
  def change
    add_column :records, :total_insured, :number
    add_column :records, :start_date, :date
    add_column :records, :end_date, :date
    add_column :records, :policy_no, :string
  end
end
