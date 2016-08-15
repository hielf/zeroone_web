class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :prize, precision: 12, scale: 2, default: 0
      t.string :image
      t.string :desc
      t.string :url
      t.string :status

      t.timestamps null: false
    end
  end
end
