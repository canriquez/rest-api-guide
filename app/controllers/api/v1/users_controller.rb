class Api::V1::UsersController < ApplicationController
    #skip_before_action :verify_authenticity_token
    before_action :set_user, only: [:show, :update, :destroy]


    #GET /users

    def index
        @users = User.all 
        json_response(@users)
    end
    

    # GET /user/:id
    def show
        json_response(@user)
    end

    def set_user
        @user = User.find(params[:id])
    end

end
