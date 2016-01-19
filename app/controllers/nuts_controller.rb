class NutsController < ApplicationController
  
  def get_totalunread(name)

    user_id = (User.where(Name: name)).ids[0]
    user = User.find(user_id)
    unreaded_acs = JSON.parse(user.unreaded)
    @total_unread = []
    unreaded_acs.each do |key,value|
      temp = {}
      temp["activity"] = Activity.find(key)
      temp["num"] = value
      @total_unread.push(temp)
    end
    return @total_unread
  end
  
  
  def index
  end
  
  def show
    
  end
  
  def user_profile_tab
    puts "-----------------params",params[:tab]
    get_request = params[:tab]
    if get_request=="info"
      user_name = params[:name]
      user_id = (User.where(Name: user_name)).ids[0]
      @user = User.find(user_id)
      respond_to do |format|
			  format.html {render partial: "person_info",:object =>@user}
  		end
    elsif get_request=="unread"
      user_name = params[:name]
      user_id = (User.where(Name: user_name)).ids[0]
      user = User.find(user_id)
      """
      unreaded_acid = JSON.parse(user.unreaded).keys
      @unreaded_ac = Activity.find(unreaded_acid)
      """
      unreaded_acs = JSON.parse(user.unreaded)
      puts "------------unreaded_acs",unreaded_acs
      @total_unread = []
      unreaded_acs.each do |key,value|
        puts "key",key
        puts "value",value
        temp = {}
        temp["activity_id"] = Activity.find(key).id
        temp["activity_name"] = Activity.find(key).name
        temp["num"] = value
        @total_unread.push(temp)
      end
      puts "-----------------total_unread",@total_unread
      respond_to do |format|
			  format.html {render partial: "unread_activity",:object =>@total_unread}
		  end
    else
      puts "-----------------bad"
    end
    
  end
  
  def user_profile
    user_name = params[:name]
    
    
    
    
    puts "%%%%%%%%%%%%%"
    puts user_name
    user_id = (User.where(Name: user_name)).ids[0]
    user = User.find(user_id)
    unreaded_acid = JSON.parse(user.unreaded).keys
    @unreaded_ac = Activity.find(unreaded_acid)
=begin
    unreaded_acid_array = JSON.parse(user.unreaded).keys
    unreaded_acname_array = []
    for id in unreaded_acid_array
      unreaded_acname.append((Activity.find(id)).name)
    end
    @unreaded_acname_list = unreaded_acname_array
=end
  end
end
