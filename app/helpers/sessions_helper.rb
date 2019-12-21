module SessionsHelper
    # a new remember_token is set when logged in to prevent theft or stale
    def log_in user
        @user.update_attribute(:remember_token, SecureRandom.urlsafe_base64)
        cookies.permanent[:remember_token] = @user.remember_token
    end

    # Retrieve the current_user if it hasn't already been set
    # Return if the current_user is nil after trying to retrieve it
    def current_user
        remember_token = cookies.permanent[:remember_token]
        @current_user ||= User.find_by(remember_token: remember_token)
        return if @current_user.nil?
    end

    def logout_user
        cookies.permanent[:remember_token] = nil
        @current_user = nil
    end

end
