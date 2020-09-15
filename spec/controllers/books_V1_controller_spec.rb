require 'rails_helper'

RSpec.describe 'books V1 API', type: :request do

    #initialize test data

    let!(:books) {create_list(:book, 10)}
    let(:book_id) { books.first.id }

    # Test suite for GET /books
    describe 'GET /api/v1/books' do
        # make HTTP get request before each example
        before { get '/api/v1/books' }

        it 'returns books' do
        # Note `json` is a custom helper to parse JSON responses
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
        expect(response).to have_http_status(200)
        end
    end

 
  # Test suite for GET /api/v1/books/:id
  describe 'GET /api/v1/books/:id' do
    before { get "/api/v1/books/#{book_id}" }

    context 'when the record exists' do
      it 'returns the book' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(book_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:book_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find Book with 'id'=100\"}")
      end
    end
  end    


  # Test suite for POST /api/v1/books
  describe 'POST /api/v1/books' do
        # valid payload
        let(:valid_attributes) { { title: 'Learn Elm', author: 'lorem', category: 'popo' } }
    
        context 'when the request is valid' do
          before { post '/api/v1/books', params: valid_attributes }
    
          it 'creates a book' do
            expect(json['title']).to eq('Learn Elm')
            expect(json['author']).to eq('lorem')
            expect(json['category']).to eq('popo')
          end
    
          it 'returns status code 201' do
            expect(response).to have_http_status(201)
          end
        end
    
        context 'when the request is invalid' do
          before { post '/api/v1/books', params: { title: 'Foobar' } }
    
          it 'returns status code 422' do
            expect(response).to have_http_status(422)
          end
    
          it 'returns a validation failure message' do
            expect(response.body)
              .to match("{\"message\":\"Validation failed: Category can't be blank\"}")
          end
        end
      end

    # Test suite for PUT /api/v1/books/:id
  describe 'PUT /api/v1/books/:id' do
        let(:valid_attributes) { { title: 'Shopping' } }

        context 'when the record exists' do
        before { put "/api/v1/books/#{book_id}", params: valid_attributes }

        it 'updates the record' do
            expect(response.body).to be_empty
        end

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
        end
  end


    # Test suite for DELETE /api/v1/books/:id
  describe 'DELETE /api/v1/books/:id' do
        before { delete "/api/v1/books/#{book_id}" }

        it 'returns status code 204' do
        expect(response).to have_http_status(204)
        end
  end



end
