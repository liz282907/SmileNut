require 'json'

class ActivitesController < ApplicationController

	
	def getTotal(id)
		@activity = Activity.find(id)
		@activity_owner_name = User.find_by(@activity.user_id).Name

		@activity_comments = CommentActivity.where(activity_id: id)
		total = []
		@activity_comments.each do|activity_comment|
			tmp_dic = {}
			tmp_dic["from_name"] = User.find(activity_comment.from_id).Name
			to_name = User.find(activity_comment.to_id).Name
			if to_name== @activity_owner_name
				tmp_dic["to_name"]= ""
			else
				tmp_dic["to_name"] = to_name
			end
			tmp_dic["comment"] = activity_comment
			total.push(tmp_dic)
		end
		return total
		
	end 


	def show
		
		puts "********************"
		
		id = params[:id]
		@activity = Activity.find(id)
		@activity_owner_name = User.find_by(@activity.user_id).Name

		if(session[:user_name])
			puts "&&&&&&&&& is session user"
			
			session_user = User.find_by(Name: session[:user_name])
			unreaded_dict = JSON.parse(session_user.unreaded)
			puts unreaded_dict
			puts id
			if (unreaded_dict.has_key?(id))
				puts "&&&&&&&& has_key"
				unreaded_dict.delete(id)
			end
			
			session_user.update_attributes(:unreaded => unreaded_dict.to_json)
		end


		# if (session[:user_name])
		# 	@activity_owner_id = User.find_by(Name: session[:user_name]).id
		 
		# end
		
		@activity_comments = CommentActivity.where(activity_id: id)
		@total = []
		@activity_comments.each do|activity_comment|
			tmp_dic = {}
			tmp_dic["from_name"] = User.find(activity_comment.from_id).Name
			to_name = User.find(activity_comment.to_id).Name
			if to_name== @activity_owner_name
				tmp_dic["to_name"]= ""
			else
				tmp_dic["to_name"] = to_name
			end
			tmp_dic["comment"] = activity_comment
			@total.push(tmp_dic)
		end
	end
"""		
		@activity_comments = CommentActivity.where(activity_id: id)
		@from_to_array = []
		@activity_comments.each do|activity_comment|
		
			tmp_array = []
			tmp_array.push(User.find(activity_comment.from_id).Name)
		    tmp_array.push("")
		    # tmp_array.push(User.find(activity_comment.to_id).Name)
			tmp_array.push(activity_comment)
			@from_to_array.push(tmp_array)
		end
"""

	



	def all_events
		
		
		@activities = Activity.all()
		@activities.each do |activity|
			puts activity.start_date.strftime("%Y-%m-%d %H:%M")
			puts activity.to_s
		end
		#@activities = Activity.all()
		@candidate = []
		
		# 分页请求
		if(params[:page])
			activity_count = @activities.count
			puts "---------------------activity_count",activity_count
			request_page = params[:page].to_i
			if activity_count >= request_page*9
				@activities_in_one_page = Activity.find([(request_page-1)*9+1,request_page*9+1])
				respond_to do |format|
					format.html { render partial: "activities_partial",:object =>@activities_in_one_page}
				end	
			elsif activity_count> (request_page-1)*9
				gap = activity_count-(request_page-1)*9
				@activities_in_one_page = (Activity.all())[-1*gap]
				respond_to do |format|
					format.html { render partial: "activities_partial",:object =>@activities_in_one_page}
				end	
			else
				respond_to do |format|
					format.html { render partial: "activity_not_found"}
				end	
			end
			
		end
		
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
		
		# if (params[:edit] == 1)
		# 	session[:edit] = true
		# end
		
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

	def add_in_comment
		puts "-^^^^^^^^^^^^^^^^^^^^^^^^^",params
		to_name = params[:comment_to_name]
		to_id = (User.where(Name: to_name)).ids[0]
		
		content = params[:content]
		
		from_name = params[:comment_from_name]
		from_id = (User.where(Name: from_name)).ids[0]
		activity = params[:activity_id]
		
		showTo = true
		if User.find(to_id).Name == to_name
			showTo = false
		end
			
		com = CommentActivity.create(:activity_id =>activity, :content => content, :from_id =>from_id, :to_id => to_id)
		
		if com
			puts "---------------------good insert to CommentActivity table"
		else 
			puts "-----------------------wrong insert to CommentActivity table"
			puts com.errors.full_messages
		end
		
		#更新未读回复字段
		activity_owner = User.find(to_id)
		unread_json = {}
		
		if (activity_owner.unreaded)
			unread_json = JSON.parse(activity_owner.unreaded)
			if(unread_json.has_key?(activity))
				unread_json[activity] += 1
			else
				unread_json[activity] = 1
			end
		else
			unread_json[activity] = 1
		end
		activity_owner.update!(unreaded: unread_json.to_json)
		
		

		

		#刷新回复框
		@total = getTotal(activity)
		respond_to do |format|
			format.html {render partial: "comment_partial",:object=>@total}
		end
		
		"""
		 respond_to do |format|
		 	respond = {
		 		respond_from_name: from_name,
		 		respond_to_name: to_name,
		 		respond_to_content: content,
		 		respond_showTo: showTo
		 	}.to_json
	     	format.json {render :json => respond}
	         
     	 end
     	 """
		
	end
	
	def add_comment
		if (session[:user_name])
			puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
			from_id = User.find_by(Name: session[:user_name]).id
			puts params[:to_id]
			puts params[:activity_id]
			CommentActivity.create(:activity_id => params[:activity_id], :content => params[:comment][:comment_content], :from_id => from_id, :to_id => params[:to_id])			
			# to_user = User.find(params[:to_id])
			params[:from_name] = session[:user_name]
			# params[:to_name] = to_user["Name"]
			params[:to_name] = ""
			puts "---------------------",params
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
