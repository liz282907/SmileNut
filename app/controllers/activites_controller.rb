require 'json'

class ActivitesController < ApplicationController

	def show
		id = params[:id]
		@activity = Activity.find(id)
		if (session[:user_name])
			@activity_owner_id = User.find_by(Name: session[:user_name]).id
		 
		end
		
		@activity_comments = CommentActivity.where(activity_id: id)
		@from_to_array = []
		@activity_comments.each do|activity_comment|
			tmp_array = []
			tmp_array.push(User.find(activity_comment.from_id).Name)
			tmp_array.push(User.find(activity_comment.to_id).Name)
			@from_to_array.push(tmp_array)
		end
			


	end



	def all_events

		@activities = Activity.all()
		@activities.each do |activity|
			puts activity.start_date.strftime("%Y-%m-%d %H:%M")
			puts activity.to_s
		end
		#@activities = Activity.all()
		@candidate = []
		if(params[:tag])
			@activities.each do |activity|
				@get_tag = params[:tag]
				puts @get_tag
				@tags = activity.tag.split(",")
				@tags.each do |tag|
					if(tag == @get_tag)
						@candidate.push(activity.id)
					end
				end
			end
			puts @candidate
			@activities = Activity.find @candidate

		end
		
		if (params[:edit] == 1)
			session[:edit] = true
		end
		
	end

	def edit
		puts params[:data]
		puts "-----------------",params.inspect
		@activity = Activity.find(params[:id])
		
	end
	
	def delete
		id = params[:id]
		@activity = Activity.find(id)
		@activity.destroy
		redirect_to activites_all_events_path
	end	
	
	
	def update
		params.permit!
		puts params[:activity]
		id = params[:id].to_i
		puts "----------id",id
		update_activity = Activity.find(id)
		update_activity.update_attributes(params[:activity])
		redirect_to {controller:"activites",action:"show",id: id}
		
	end

	#------其他def-------
	def add
	
		@activity = Activity.find params[:acid]
		if (params[:type] == "recommend")
			@activity.update_attributes(:recommend => (@activity.recommend + 1))
		else
			@activity.update_attributes(:want_join => (@activity.want_join + 1))
		end
		
		redirect_to :back
	end

	
	
	def add_comment
		if (session[:user_name])
			puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
			from_id = User.find_by(Name: session[:user_name]).id
			puts params[:to_id]
			puts params[:activity_id]
			CommentActivity.create(:activity_id => params[:activity_id], :content => params[:comment][:comment_content], :from_id => from_id, :to_id => params[:to_id])
			to_user = User.find(params[:to_id])
			if (not to_user.unreaded)
				tmp_hash = {}
				tmp_hash[params[:activity_id]]=[].push(from_id)
				json_str = JSON.dump(tmp_hash)
				to_user.update_attributes(:unreaded => json_str)
			else
				extract_str = to_user.unreaded
				tmp_hash = JSON.load(extract_str)
				tmp_hash.has_key?(:activity_id) ? tmp_hash[:activity_id].push(from_id) : [].push(from_id)
				json_str = JSON.dump(tmp_hash)
				to_user.update_attributes(:unreaded => json_str)
					
			end
			
		end
		redirect_to :back
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
		activity_param[:user_id] = (User.where(:name => session[:user_name])).ids[0]
		activity_param[:content] = @launch_activity["content"]
		activity_param[:tag] = @launch_activity["tag"]
		activity_param[:detail_addr] = @launch_activity["detail_addr"]
		
		
		activity_param[:start_date] = @launch_activity["start_date"]
		activity_param[:end_date] = @launch_activity["end_date"]
		
		activity_param[:recommend]=0
		activity_param[:province]="北京市"
		activity_param[:district]="怀柔区"
		activity_param[:city]="北京市"
		
		
		activity_added = Activity.new(activity_param)
		if activity_added.save
			logger.debug {"success"}
			user = User.find(activity_param[:user_id])
			puts user
			activity_ids = []
			if user.Sponsor_Activity
			  activity_ids = JSON.parse(user.Sponsor_Activity)
			end
			activity_ids.push(user.id)
			info = user.update!(Sponsor_Activity: activity_ids.to_json)
			redirect_to  "/activites/all-events"
		else
		  puts "-------------------------"
		  puts params["activity"]["start_date"]
		  puts params["activity"]["end_date"]
		  puts "activity save info"
		  puts activity_added.inspect
		  render plain: activity_added.errors.full_messages.inspect
		  
		end
		#   render plain: activity_added.inspect
		
	end
	

end
