module SessionsHelper

    #logs in given user
    #this temporary cookie is automatically encrypted
    def log_in user
        session[:user_id] = user.id
    end

    # Returns current logged in user. For use in the views and for redirects etc.
    def current_user
        # = is ASSIGNMENT. It's used here to eliminate duplication of writing session[:user_id] twice. user_id is used instead
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            # checks that the token in the cookie matches the token for the user
            if user && user.authenticated?(cookies[:remember_token])
                # sets a session user_id
                log_in user
                @current_user = user
            end
        end
    end


    # remembers a user ina persistent sessoin
    def remember user
        # generates the remember token and saves it's encrypted form to the db
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    def forget user
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end

    # Returns true if current_user is not nil
    def logged_in?
        !current_user.nil?
    end

    private

        def logged_in_user
            unless logged_in?
                flash[:error] = "Please log in"
                redirect_to login_path
            end
        end
        
end
