module Api
  module V1
    class BooksController < ApplicationController
      MAX_PAGINATION_LIMIT = 100

      def index
        books = Book.limit(params_limit)
        render json: BooksRepresenter.new(books).as_json
      end

      def create
        author = Author.create!(author_params)
        book = Book.new(book_params.merge(author: author))
        book_create_status(book)
      end

      def destroy
        book_to_destroy = find_book
        book_to_destroy.destroy!

        head :no_content
      end

      private

      def book_params
        params.require(:book).permit(:title)
      end

      def author_params
        params.require(:author).permit(:firstname, :lastname, :age)
      end

      def book_create_status(book)
        if book.save
          render json: BookRepresenter.new(book).as_json, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def find_book
        @book ||= Book.find(params[:id])
      end

      def params_limit
        [MAX_PAGINATION_LIMIT, params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i].min
      end
    end
  end
end