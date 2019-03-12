class ToppagesController < ApplicationController
  
  def index
    if logged_in? 
      @timeline = current_user.timelines.build
      @timelines = current_user.following_timelines.order("created_at DESC")
    end
  end
end
