class GoodsController < ApplicationController
  
  before_action :require_user_logged_in

  def create
    timeline = Timeline.find(params[:timeline_id])
    current_user.good(timeline)
    
    flash[:success] = "goodに追加しました。"
    redirect_back(fallback_location: root_url)
  end

  def destroy
    timeline = Timeline.find(params[:timeline_id])
    current_user.ungood(timeline)
    
    flash[:success] = "goodを解除しました。"
    redirect_back(fallback_location: root_url)
  end
  
end
