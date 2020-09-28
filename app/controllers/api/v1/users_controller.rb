class Api::V1::UsersController < ApplicationController
    #skip_before_action :verify_authenticity_token
    before_action :authorized, only: [:auto_login]
    before_action :set_user, only: [:show, :update, :destroy]


    # GET /api/v1/user/:id
    def show
        #json_response(@user)
        json_response(User.find(params[:id]))
    end

    #  POST /api/v1/users
    def create
        @user = User.create(user_params)

        if @user.valid?
            token = encode_token({user_id: @user.id})
            render json: {user: @user, token: token}
        else
            render json: {user: @user.errors}, status: :unprocessable_entity
        end

        #json_response(@user,:created)
    end

    # Loggin In

    def login 
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            token = encode_token({user_id: @user.id})
            render json: {user: @user, token: token}
        else 
            render json: {error: "Wrong username or pass"}
        end 
    end

    def auto_login
        render json: @user
    end

     # PATCH/PUT /api/v1/users/:id
    def update
        #@user.update(user_params)
        #head :no_content
        if @user.update(user_params)
            render json: {user: @user}, status: :ok
        else 
            render json: @user.errors, status: :unprocessable_entity
        end
    end


    # DELETE /api/v1/users/:id
    def destroy
        @user.destroy
        head 204
    end

    private 

    def user_params
        # whitelist params
        params.permit(:username, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end

end
