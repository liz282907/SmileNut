class NutsController < ApplicationController
  def index
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
