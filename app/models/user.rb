class User < ApplicationRecord
    #has_secure_password: adds functionality: 
    #       a password_digest attribute, 
    #       a pair of virtual attributes (password & password_confirmation), 
    #       an authenticate method that returns user when the password is correct. 
    #   *has_secure_password uses the bcrypt hash function (include in GEMFILE)

    before_create :create_remember_token
    has_secure_password

    
    # remember user in database for auto login
    # run every time user logs in preventing tokens from getting old and vulnerable
    def remember 
        self.remember_token = User.new_token
        update_attribute(:remember_token, User.encrypt(remember_token))
    end

    def forget
        update_attribute(:remember_token, nil)
    end

    private
        # Using User.new_token, a new random string is generated
        def self.new_token
            SecureRandom.urlsafe_base64
        end

        def self.encrypt(string)
            Digest::SHA1.hexdigest(string)
        end

        # sets the remember token for the current instance of User
        def create_remember_token
            self.remember_token = User.encrypt(User.new_token)
        end
end


