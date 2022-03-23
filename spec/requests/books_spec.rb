require 'rails_helper'

RSpec.describe "Books API" do
  it "returns all books" do 
     FactoryBot.create(:book, title: "Hotel Magestic", author: "Uche Kalu")
     FactoryBot.create(:book, title: "Unsung", author: "Benjamin King")
    
    get "/api/v1/books"
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(2)
  end
end