class Api::V1::BooksController < ApplicationController
    #skip_before_action :verify_authenticity_token
    before_action :set_book, only: [:show, :update, :destroy]


    #GET /api/V1/books

    def index
        @books = Book.all 
        json_response(@books)
    end
    

    # GET /api/v1/book/:id
    def show
        json_response(@book)
    end

    #  POST /api/v1/books
    def create
        @book = Book.create!(book_params)
        json_response(@book,:created)
    end


     # PUT /api/v1/books/:id
    def update
        @book.update(book_params)
        head :no_content
    end


    # DELETE /api/v1/books/:id
    def destroy
        @book.destroy
        head :no_content
    end


    def book_params
        # whitelist params
        params.permit(:title, :author, :category)
      end

    def set_book
        @book = Book.find(params[:id])
    end

end
