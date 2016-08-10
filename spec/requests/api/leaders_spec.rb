require 'rails_helper'

RSpec.describe "leaders" do
  describe "POST #create" do
    it "create a new leader" do
      Leader.delete_all
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      valid_attributes = {
        "channel"=>"001", 
        "name"=>"杨柳", 
        "phone"=>"13563312989", 
        "sex"=>"1", 
        "workplace"=>"山东日照东港区", 
        "birth"=>"1995/10/10", 
        "income"=>"3000", 
        "hasCreditCard"=>"Y", 
        "mortgage"=>"Y", 
        "loanExperience"=>"是", 
        "profession"=>"0", 
        "payoffType"=>"0", 
        "applyDate"=>"2016-07-06 02:30:41"
      }
      post "/api/leaders", valid_attributes, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(201)
      leader = Leader.first
      expect(leader.user_id).to eq user.id
      ["name", "phone", "sex", "workplace", "income", "mortgage", "channel"].each do |item|
        expect(leader.send(item)).to eq valid_attributes[item]
      end
      expect(leader.birth.to_date).to eq valid_attributes["birth"].to_date
      expect(leader.has_credit_card).to eq valid_attributes["hasCreditCard"]
      expect(leader.loan_experience).to eq valid_attributes["loanExperience"]
      expect(leader.job).to eq valid_attributes["profession"]
      expect(leader.payoff_type).to eq valid_attributes["payoffType"]
    end

    it "failed to create leader without user" do
      valid_attributes = attributes_for(:leader)
      post "/api/leaders", {leader: valid_attributes}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
  end

  describe "GET #index" do
    it "get someone's leaders" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      leader = create(:leader, user_id: user.id, name: "李响", phone: "11111111111", loan_state: "some reason")
      leader.confirm
      get "/api/leaders",{}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["leaders"].first
      expect(json["name"]).to eq "李*"
      expect(json["phone"]).to eq "1111111****"
      expect(json["state"]).to eq "通过"
      expect(json["loan_state"]).to eq "some reason"
      expect(json["date"]).to eq I18n.l(leader.updated_at.to_date, format: :long)
    end

    it "get leader with phone" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      leader = create(:leader, user_id: user.id, name: "李响", phone: "11111111111", loan_state: "some reason")
      leader.confirm
      get "/api/leaders",{phone: "1111"}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["leaders"]
      expect(json.count).to eq 1
    end

    it "get no leader with phone" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      leader = create(:leader, user_id: user.id, name: "李响", phone: "11111111111", loan_state: "some reason")
      leader.confirm
      get "/api/leaders",{phone: "2222"}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["leaders"]
      expect(json).to be_blank
    end
  end
end