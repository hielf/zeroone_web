FactoryGirl.define do
  factory :user do
    openid {Faker::Number.number(10).to_s}
    avatar File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))
    name "MyString"
    cell "11111111111"
    sequence(:email) { |n| "foobar#{n}@example.com" }
    id_card "MyString"
    bank_card "MyString"
    alipay "MyString"
  end
end
