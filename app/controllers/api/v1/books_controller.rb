module Api
  module V1
    class BooksController < ApplicationController
      def index
        books = Book.all
        render json: BooksRepresenter.new(books).as_json
      end

      def create
        book = Book.new(book_params)
        book_create_status(book)
      end

      def destroy
        book_to_destroy = find_book
        book_to_destroy.destroy!

        head :no_content
      end

      private

      def book_params
        params.require(:book).permit(:title, :author)
      end

      def book_create_status(book)
        if book.save
          render json: book, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def find_book
        @book ||= Book.find(params[:id])
      end
    end
  end
end