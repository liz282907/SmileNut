# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

<<<<<<< HEAD
admins = [{:name => 'daige', :password => 'daige'},
    {:name => 'chenlu', :password => 'chenlu'},
    {:name => 'yangmeifang', :password => 'yangmeifang'},
  	 ]

admins.each do |admin|
    Admin.create!(admin)
end
=======


#------------------------下面是经测试可以成功执行-----------------------
#encoding: utf-8

#t=Time.now
#Activity.create({:name=>"野长城",:created_at=>t,:updated_at=>t,:content=>"野长城风景很漂亮，值得一爬"})
>>>>>>> origin/master
