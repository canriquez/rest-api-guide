class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler


    #before_action :authorized


    def encode_token(payload)
        JWT.encode(payload, 'elxhongodelsolda2')
    end


    def auth_header
        # { Authorization: 'Bearer <token>'}
        request.headers['Authorization']
    end


    def decoded_token
        if auth_header
            token = auth_header.split(' ')[1]
            # header: {'Authorization': 'Bearer <token>' }

            begin
                JWT.decode(token, 'elxhongodelsolda2', true, algorithm: 'H256')
            rescue JWT::DecodeError
                nil
            end
        end
    end



    def logged_in_user
        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end


    def logged_in?
        !!logged_in_user
    end


    def authorized
        render json: {message: 'Please log in to continue...'}, status: :unauthorized unless logged_in?
    end

end
