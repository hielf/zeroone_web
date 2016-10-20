class CreateCarousels < ActiveRecord::Migration
  def change
    create_table :carousels do |t|
      t.string :first
      t.string :second
      t.string :third

      t.timestamps null: false
    end
  end
end
