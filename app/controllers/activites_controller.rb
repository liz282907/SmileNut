class ActivitesController < ApplicationController 
  def all_events
  end
  
  def launch
  #  @activity = Activity.launch(params[:activity])
  end
  
  def new
    @activity = Activity.new
  end
  
  def create
    @launch_activity = params[:activity]
    activity_param = {}
    activity_param[:name] = @launch_activity["name"]
   # activity_param[:user_id] = User.where(:name => session[:user_name]).ids
    activity_param[:user_id]=1
    activity_param[:content] = @launch_activity["content"]
    activity_param[:tag] = @launch_activity["tag"]
    activity_param[:place] = @launch_activity["place"]
    
    
    activity_param[:start_date] = @launch_activity["start_date"]
    activity_param[:end_date] = @launch_activity["end_date"]
    
    
    activity_added = Activity.new(activity_param)
    if activity_added.save
      logger.debug {"success"}
      redirect_to nuts_path
    else
      puts "-------------------------"
      puts params["activity"]["start_date"]
      puts params["activity"]["start_date"]
      render plain: activity_added.errors.full_messages.inspect
   #   render 'new'
      
    end
 #   render plain: activity_added.inspect
    
  end
end
