class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:sessions][:email].downcase)
        if @user && @user.authenticate(params[:sessions][:password])
            log_in @user
            remember @user
            flash[:success] = "Welcome back to the Club, homie"
            redirect_to root_url
        else
            flash.now[:danger] = 'Invalid email/password combination'
            render 'new'
        end
    end

    def destroy
        # to prevent errors when user has multiple windows open
        log_out if logged_in?
        flash[:success] = "You have logged out. Peace!"
        redirect_to root_url
    end
end
