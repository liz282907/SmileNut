class Activity < ActiveRecord::Base
    
    validates :name,presence:true,length:{maximum:20}
    validates :user_id,presence:true,uniqueness:true
    validates :content,presence:true
    validates :place,presence:true
    validates :start_date,presence:true
    validates :end_date,presence:true
    validates :tag,presence:true
    validates :content,presence:true
    
end
