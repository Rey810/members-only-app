class User < ApplicationRecord
    #adds functionality: 
    #       a password_digest attribute, 
    #       a pair of virtual attributes (password & password_confirmation), 
    #       an authenticate method that returns user when the password is correct. 
    #   *has_secure_password uses the bcrypt hash function (include in GEMFILE)
    has_secure_password
end


