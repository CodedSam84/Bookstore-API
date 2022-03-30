require 'rails_helper'

RSpec.describe "Books API" do
  describe "GET /books" do
    before do
      FactoryBot.create(:book, title: "Hotel Magestic", author: "Uche Kalu")
      FactoryBot.create(:book, title: "Unsung", author: "Benjamin King")
    end

    it "returns all books" do
      get "/api/v1/books"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "POST /books" do
    it "creates a new book" do
      expect {
        post "/api/v1/books", params: { book: { title: "Last Days", author: "JWT" }}
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      
    end
  end

  describe "DELETE /books/:id" do
    let!(:book) { FactoryBot.create(:book, title: "Metaverse", author: "Benson") }

    it "deletes a book" do

      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end

end