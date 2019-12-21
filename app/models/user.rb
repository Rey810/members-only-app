class User < ApplicationRecord
    #has_secure_password: adds functionality: 
    #       a password_digest attribute, 
    #       a pair of virtual attributes (password & password_confirmation), 
    #       an authenticate method that returns user when the password is correct. 
    #   *has_secure_password uses the bcrypt hash function (include in GEMFILE)

    before_create :create_remember_token
    has_secure_password

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


