require 'rails_helper'

RSpec.describe "feedbacks" do
  describe "POST #create" do
    it "create a new feedback" do
      Feedback.delete_all
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      post "/api/feedbacks", {content: "foobar"}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(201)
      expect(Feedback.first.content).to eq "foobar"
      expect(Feedback.first.user_id).to eq user.id
    end

    it "failed to create feedback without user info" do
      post "/api/feedbacks", {content: "foobar"}
       expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
  end
end