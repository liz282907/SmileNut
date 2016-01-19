class User < ActiveRecord::Base
    has_many :comment_activities
    
end
