require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  describe "POST /authenticate" do
    it "authenticates the client" do
      post "/api/v1/authenticate", params: { username: "Samuel", password: 12345 }

      expect(response).to have_http_status(:created)
      expect(parse_response_body).to eq(
        {
          "token" => "1234"
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
  end
end