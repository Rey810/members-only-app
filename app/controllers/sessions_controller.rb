class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:sessions][:email].downcase)
        if @user && @user.authenticate(params[:sessions][:password])
            log_in @user
            current_user
        else
            render 'new'
        end
    end

    def destroy
        logout_user
        redirect_to root_url
    end
end
