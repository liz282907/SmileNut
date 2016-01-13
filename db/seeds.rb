# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

=begin
=======
"""
>>>>>>> c
admins = [{:name => 'daige', :password => 'daige'},
    {:name => 'chenlu', :password => 'chenlu'},
    {:name => 'yangmeifang', :password => 'yangmeifang'},
  	 ]

admins.each do |admin|
    Admin.create!(admin)
end
<<<<<<< HEAD
=end

#------------------------活动表（activities）数据添加----------------------
#encoding: utf-8

t=Time.now
#Activity.create({:name => "雁栖湖一日游", :user_id => 1, :content => "雁栖湖的风景很漂亮，很漂浪呀很漂亮～", :participant_id => "2,3,4", :tag => "旅行", :province => "北京市", :city => "北京市", :district => "怀柔区", :detail_addr => "怀北镇雁栖湖风景区", :start_date => "2016-01-04 08:00:00", :end_date => "2016-01-04 18:00:00", :recommend => 4, :want_join => 5, :admin_id => 1, :created_at=>t,:updated_at=>t})
Activity.create({:name => "八旗与八旗子弟", :user_id => 4, :content=> "讲述了满清时期的八旗的社会地位以及社会影响", :participant_id => "2,3,4", :tag => "讲座", :province => "北京市", :city => "北京市", :district => "怀柔区", :detail_addr => "中国科学院大学雁栖湖校区教1-101", :start_date => "2016-01-06 19:00:00", :end_date => "2016-01-06 21:00:00", :recommend => 4, :want_join => 5, :admin_id =>3, :created_at=>t,:updated_at=>t})



#------------------------活动评论表（comment_activities）数据添加----------------------
#encoding: utf-8
=begin
t=Time.now
CommentActivity.create({:from_id => 1, :to_id => 2, :activity_id => 7, :content => "活动很不错！！oh yeah～", :created_at=>t,:updated_at=>t})
=end


#------------------------下面是经测试可以成功执行-----------------------
#encoding: utf-8
=begin
t=Time.now
ac1 = Activity.create({:name => "雁栖湖一日游", :user_id => 1, :content => "雁栖湖的风景很漂亮，很漂浪呀很漂亮～", :participant_id => "2,3,4", :tag => "旅行", :province => "北京市", :city => "北京市", :district => "怀柔区", :detail_addr => "怀北镇雁栖湖风景区", :start_date => "2016-01-04 08:00:00", :end_date => "2016-01-04 18:00:00", :recommend => 4, :want_join => 5, :admin_id => 1, :created_at=>t,:updated_at=>t})
ac2 = Activity.create({:name => "八️旗与八旗子弟", :user_id => 1, :content=> "讲述了满清时期的八旗的社会地位以及社会影响", :participant_id => "2,3,4", :tag => "讲座", :province => "北京市", :city => "北京市", :district => "怀柔区", :detail_addr => "中国科学院大学雁栖湖校区教1-101", :start_date => "2016-01-06 19:00:00", :end_date => "2016-01-06 21:00:00", :recommend => 4, :want_join => 5, :admin_id =>3, :created_at=>t,:updated_at=>t})

puts "------",ac1.errors.full_messages
puts ac2.errors.full_messages

=end

