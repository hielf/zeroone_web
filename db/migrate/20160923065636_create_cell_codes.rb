class CreateCellCodes < ActiveRecord::Migration
  def change
    create_table :cell_codes do |t|
      t.string :cell
      t.string :code

      t.timestamps null: false
    end
  end
end
