# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = Admin.create!(
  name: "foobar",
  password: "111111")
# user = User.create(
#   openid: Faker::Number.number(10).to_s,
#   avatar: File.open(File.join(Rails.root, 'spec/fixtures/rails.png')),
#   name: "foobar",
#   cell: "11111111111",
#   email: Faker::Internet.email,
#   id_card: "ID card",
#   bank_card: "Bank card",
#   alipay: "alipay"
#   )
