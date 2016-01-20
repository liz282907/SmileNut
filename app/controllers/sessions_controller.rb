class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(Email: params[:session][:email].downcase) 
    if user and user.authenticate(params[:session][:password])
      log_in user 
      redirect_to activites_all_events_path
    else
      flash[:danger] = 'Invalid email/password combination'
      render "new"
    end 
  end
  
  def destroy
    log_out
    redirect_to activites_all_events_path
  end
end
