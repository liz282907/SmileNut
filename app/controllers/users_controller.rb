class UsersController < ApplicationController
  def new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    print "create........"
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "欢迎您!" 
      unreaded_init = {}
      unreaded_info = unreaded_init.to_json
      @user.update_attributes(unreaded: unreaded_info)
      redirect_to activites_all_events_path
      print "success..."
    else
      render "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to activites_all_events_path
    else
      render 'edit'
    end
  end
  private
    def user_params
      params.require(:user).permit(:Name, :Email, :password, :password_confirmation)
    end
    
    def logged_in_user 
      unless logged_in? 
        store_location 
        flash[:danger] = "Please log in." 
        redirect_to login_path 
      end 
    end
    
    def correct_user 
      @user = User.find(params[:id]) 
      redirect_to(root_path) unless current_user?(@user) 
    end
end
