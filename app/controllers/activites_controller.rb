
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

	
	def delete
		id = params[:id]
		@activity = Activity.find(id)
		@activity.destroy
		redirect_to activites_all_events_path
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



end
