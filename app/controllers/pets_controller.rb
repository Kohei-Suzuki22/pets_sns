class PetsController < ApplicationController
  
    before_action :require_user_logged_in 
    before_action :dry_user_params, except: [:update,:destroy]
    before_action :correct_pet_user, only: [:update]
    before_action :correct_user, only: [:new,:create,:edit]

  def index
    @pets = @user.pets
  end

  def new
    @pet = @user.pets.build
  end

  def create
    @pet = @user.pets.build(pet_params)
    
    if @pet.save
      flash[:success] = "ペットを登録しました。"
      redirect_to pets_path
    else 
      flash.now[:danger] = "ペットの登録に失敗しました。"
      render :new 
    end
      
  end

  def edit
    @pet = @user.pets.find(params[:id])
  end

  def update
    @user = User.find(params[:pet][:user_id])
    
    @pet = @user.pets.find(params[:id])

    if @pet.update(pet_params) 
      flash[:success] = "ペットのプロフィールを編集しました。"
      redirect_to pets_path(@user)
    else 
      flash.now[:danger] = "ペットのプロフィールを編集できませんでした。"
      render :edit 
    end
      
  end

  def destroy
    
    @pet = Pet.find(params[:id])
    if @pet.user == current_user 
      @pet.destroy 
      flash[:success] = "登録されたペットから削除しました。"
      redirect_to current_user
    else
      redirect_back(fallback_location: root_url)
    end
    
  end
  
  private
  
  def dry_user_params
    @user = User.find(params[:user_id])
  end
  
  def dry_pet_params
    @pet = @user.pets.find(params[:id])
  end

  def correct_pet_user
    unless current_user == User.find(params[:pet][:user_id])
      redirect_to root_url
    end
  end
  
  def pet_params
    params.require(:pet).permit(:name,:profile,:image,:remove_image,:user_id)
  end 
end
