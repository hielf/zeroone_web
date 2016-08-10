class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :openid
      t.string :avatar
      t.string :number
      t.string :name
      t.string :cell
      t.string :email
      t.string :id_card
      t.string :bank_card
      t.string :alipay

      t.timestamps null: false
    end
  end
end
