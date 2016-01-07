class ActivitesController < ApplicationController

	def show
		id = params[:id]
		@activity = Activity.find(id)
		@activity_owner_id = User.find_by(name: session[:user_name]).id
	end



	def all_events
		puts "************************************************"

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




end
