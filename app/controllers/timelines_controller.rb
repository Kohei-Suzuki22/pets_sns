class TimelinesController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_timeline_user, only: [:destroy]
  
  def create
    @timeline = current_user.timelines.build(timeline_params)
    
    if @timeline.save 
      flash[:success] = "投稿しました。"
      redirect_to root_url
    else 
      @timelines = current_user.following_timelines.order("created_at DESC")
      flash.now[:danger] = "投稿を失敗しました。"
      render "toppages/index"
    end
    
  end

  def destroy
    @timeline.destroy 
    
    flash[:success] = "投稿を削除しました。"
    redirect_back(fallback_location: root_path)
    
  end
  
  private 
  
  def timeline_params
    params.require(:timeline).permit(:content,:image,:video)
  end
  
  def correct_timeline_user 
    @timeline = current_user.timelines.find_by(id: params[:id])
    unless @timeline 
      redirect_to root_url
    end
  end
  
end
