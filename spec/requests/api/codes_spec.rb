require 'rails_helper'

RSpec.describe "codes" do
  describe "GET #get_serial_number" do
    it "get serial_number" do
      get "/api/get_serial_number"
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["serial_number"]).to be_a(Integer)
    end
  end
end