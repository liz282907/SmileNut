class Activity < ActiveRecord::Base
    has_many :comment_activities
    validates :name,presence:true,length:{maximum:20}
    validates :user_id,presence:true
    validates :content,presence:true
    validates :detail_addr,presence:true
    validates :start_date,presence:true
    validates :end_date,presence:true
    validates :tag,presence:true
    validates :content,presence:true
    
end
