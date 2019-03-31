class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  def require_user_logged_in
    unless logged_in? 
      redirect_to login_url
    end
  end
  
  def correct_user
    unless current_user == User.find(params[:user_id])
      redirect_to root_url
    end
  end
  
  def counts(user)
    @count_timelines = user.timelines.count
    @count_good = user.like_timelines.count
    @count_followings = user.followings.count 
    @count_followers = user.followers.count
  end
  
  def dry_user_find
    @user = User.find(params[:user_id])
  end
  
end
