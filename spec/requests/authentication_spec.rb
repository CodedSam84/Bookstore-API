require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  describe "POST /authenticate" do
    let(:user){ FactoryBot.create(:user, username: "Samuel", password: "$am284") }

    it "authenticates the client" do
      post "/api/v1/authenticate", params: { username: user.username, password: user.password }

      expect(response).to have_http_status(:created)
      expect(parse_response_body).to eq(
        {
          "token" => "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.DiPWrOKsx3sPeVClrm_j07XNdSYHgBa3Qctosdxax3w"
        }
      )
    end

    it "returns errors when username is missing" do
      post "/api/v1/authenticate", params: { password: 12345 }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(parse_response_body).to eq(
        {
          "error"=>"param is missing or the value is empty: username"
        }
      )
    end

    it "returns errors when password is missing" do
      post "/api/v1/authenticate", params: { username: "Samuel" }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(parse_response_body).to eq(
        {
          "error"=>"param is missing or the value is empty: password"
        }
      )
    end

    it "returns errors when password is incorrect" do
      post "/api/v1/authenticate", params: { username: user.username, password: "sam284" }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end