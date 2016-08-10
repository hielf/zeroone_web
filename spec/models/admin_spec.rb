require 'rails_helper'

RSpec.describe Admin, type: :model do
  it "is valid" do
    expect(create(:admin)).to be_valid
  end

  it "is invalid without name" do
    admin = build(:admin, name: nil)
    admin.valid?
    expect(admin).not_to be_valid
    expect(admin.errors[:name].first).to eq I18n.t("errors.messages.blank")
  end
end
