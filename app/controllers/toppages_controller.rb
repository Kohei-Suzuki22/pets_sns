class ToppagesController < ApplicationController
  
  def index
    if logged_in? 
      @timeline = current_user.timelines.build
      @timelines = Timeline.all.order("created_at DESC")
    end
  end
end
