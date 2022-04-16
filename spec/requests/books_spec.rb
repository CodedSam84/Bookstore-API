require 'rails_helper'

RSpec.describe "Books API" do
  describe "GET /books" do
    let(:first_author) { FactoryBot.create(:author, firstname: "Uche", lastname: "Kalu", age: 33)}
    let(:second_author) { FactoryBot.create(:author, firstname: "Benjamin", lastname: "King", age: 27)}

    before do
      FactoryBot.create(:book, title: "Hotel Magestic", author: first_author)
      FactoryBot.create(:book, title: "Unsung", author: second_author)
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
        post "/api/v1/books", params: { 
          book: { title: "Last Days", author: "JWT" },
          author: { firstname: "Sandy", lastname: "Brown", age: 44 }
        }
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(Author.count). to eq(1)
      
    end
  end

  describe "DELETE /books/:id" do
    let!(:author) { FactoryBot.create(:author, firstname: "Uche", lastname: "Kalu", age: 33)}
    let!(:book) { FactoryBot.create(:book, title: "Metaverse", author: author) }

    it "deletes a book" do

      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end

end