class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:index,:show,:edit,:update]
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザを作成しました。"
      redirect_to login_url
    else
      flash.now[:danger] = "ユーザの作成に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  
  
end
