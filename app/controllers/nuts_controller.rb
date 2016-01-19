class NutsController < ApplicationController
  def index
    hot_ac_array = []
    activities = Activity.all
    activities.each do |activity|
      if(activity.recommend)
        recommend = activity.recommend
      else
        recommend = 0
      end
      if(activity.want_join)
        want_join = activity.want_join
      else
        want_join = 0
      end
      temp_array = [activity.id , (recommend + want_join)]
      hot_ac_array.append(temp_array)
    end
    hot_ac_array.sort!{|x , y| y[1] <=> x[1]}
    #puts hot_ac_array
    for acid in hot_ac_array
      Activity.find(acid[0])
    end
    
    
    
    
  end
  
  def show
    
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
