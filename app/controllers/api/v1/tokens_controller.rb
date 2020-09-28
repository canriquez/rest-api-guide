class Api::V1::TokensController < ApplicationController 
   
   #  POST /api/v1/tockens
    def create
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            token = encode_token({user_id: @user.id})
            render json: {user: @user, token: token}
        else 
            render json: {error: "Wrong username or pass"}
        end 
    end


    private

    def user_params
        # whitelist params
        params.require(:username).permit(:password)
    end

end