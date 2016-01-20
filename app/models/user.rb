class User < ActiveRecord::Base
    has_many :comment_activities
    
    validates :Name, presence: true, length: {maximum: 30}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :Email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX}, 
            uniqueness: {case_sensitive: false}
            
    has_secure_password
    validates :password, presence: true, length: {minimum: 8}
end
