class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    def has_password?(submitted_password)
        password == submitted_password
    end
    def self.authenticate(username, submitted_password)
        user = find_by_username(username)
        return nil  if user.nil?
        return user if user.has_password?(submitted_password)
    end

    validates :username, presence: true, length: { minimum: 4 }, uniqueness: true
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    validates :password, presence: true, length: { minimum: 8 }
    validates :money, presence: true, comparison: { greater_than_or_equal_to: 0 }

end
