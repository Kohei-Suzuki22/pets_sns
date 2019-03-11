class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:index,:show,:edit,:update]
  # before_action :require_user_logged_in, except: [:new,:create]
  before_action :dry_user_find, only: [:show,:edit,:update,:likes]
  
  def index
    @users = User.all
  end

  def show
    @pets = @user.pets
    counts(@user)
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

    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました。"
      redirect_to @user 
    else 
      flash.now[:danger] = "プロフィールが更新できませんでした。"
      render :edit
    end
    
  end
  
  def likes
    @pets = @user.pets
    @goods = @user.like_timelines
    counts(@user)
  end
  
  
  private
  
  def dry_user_find
    @user = User.find(params[:user_id])
  end
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:profile)
  end
  
  
end
