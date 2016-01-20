class AccountController < ApplicationController
    
  def login
      begin
          @error_message = ""
          @login_account = params[:account]
          ##TODO clear the special characters
          if @login_account
              @user_name = @login_account["email"]
              @user_pass = @login_account["password"]
              ##admin
              find_users = Admin.where(:name => @user_name)
              if find_users
                  find_users.each do |find_user|
                      if find_user.password == @user_pass
                          session[:user_name] = @user_name
                          session[:pass_word] = @user_pass
                          redirect_to nuts_path
                      end
                      break
                  end
              end
              ##user

              find_users = User.where(:name => @user_name)
              if find_users
                  find_users.each do |find_user|
                      if find_user.Password == @user_pass
                          session[:user_name] = @user_name
                          session[:pass_word] = @user_pass
                          redirect_to nuts_path
                      end
                      break
                  end
              end
              #print @user_name
              #print @user_pass
              if @error_message == ""
                  @error_message = "login fail..."
              end
          end 
      rescue Exception => e
              @error_message = "login fail..."
              puts e.message      
      end
          
  end

  def logout
    session[:user_name] = nil
    session[:pass_word] = nil
    redirect_to({:controller => "activites", :action => "all_events"})
  end


  def register
      @register_account = params[:accounts]
      print @register_account
      ##TODO clear the special characters
      @error_message_register = ""
      if @register_account
          if userExsisted or @register_account["password"] != @register_account["passwordAgain"]
              @error_message_register = "register fail..."
              print "register fail..."
          else
              user_param = {}
              user_param["Name"] = @register_account["contact"]
              user_param["Email"] = @register_account["email"]
              user_param["Password"] = @register_account["password"]
              unreaded_init = {}
              user_param["unreaded"] = unreaded_init.to_json
              user_current = User.create!(user_param)
              session[:user_name] = @register_account["contact"]
              session[:pass_word] = @register_account["password"]
              print "success..."
              redirect_to nuts_path
          end
      end
      
  end
      
  def userExsisted
      return true if User.find_by_Name(@register_account["contact"])
      return true if User.find_by_Email(@register_account["email"])
      return false
  end
  
  def showUnreadMessage
      all_unreaded_message = 0
      if(session[:user_name])
    			cur = User.find_by_Name(session[:user_name])
    			if cur.unreaded
        			cur_activities = JSON.parse(cur.unreaded)
        			cur_activities.each do |key,value|
        			  all_unreaded_message+=value
        			end
        	end
    	end
			respond_to do |format|
			  format.json {render :json => {message_num: all_unreaded_message}}
			end
	end
  
end
