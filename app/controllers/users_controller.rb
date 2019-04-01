class UsersController < ApplicationController
  
  before_action :require_user_logged_in, except: [:new,:create]
  before_action :dry_user_find, only: [:show,:edit,:update,:likes,:followings,:followers]
  before_action :dry_user_pets, only: [:show,:likes,:followings,:followers]
  before_action :correct_user, only: [:edit,:update]
  
  
  def index
    @users = User.all
  end

  def show
    counts(@user)
    show_user_info
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
  
  
  private
  
  def show_user_info
    @timelines = @user.timelines
    @goods = @user.like_timelines
    @followings = @user.followings
    @followers = @user.followers    
  end
  
  def dry_user_pets 
    @pets = @user.pets
  end
  
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:profile,:image,:remove_image)
  end


  
  
end
