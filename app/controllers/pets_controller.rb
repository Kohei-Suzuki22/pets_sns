class PetsController < ApplicationController
  
    before_action :require_user_logged_in 
    before_action :dry_user_find, except: [:update,:destroy]
    before_action :dry_pet_find, only: [:edit,:update,:destroy]
    before_action :correct_pet_user, only: [:edit,:update]
    before_action :correct_user, only: [:new,:create]

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
      redirect_to pets_url
    else 
      flash.now[:danger] = "ペットの登録に失敗しました。"
      render :new 
    end
      
  end

  def edit
  end

  def update
 
    if @pet.update(pet_params) 
      flash[:success] = "ペットのプロフィールを編集しました。"
      redirect_to pets_url(@user)
    else 
      flash.now[:danger] = "ペットのプロフィールを編集できませんでした。"
      render :edit 
    end
      
  end

  def destroy
    
    if @pet.user == current_user 
      @pet.destroy 
      flash[:success] = "登録されたペットから削除しました。"
      redirect_to current_user
    else
      redirect_back(fallback_location: root_url)
    end
    
  end
  
  private
  
  def dry_pet_find
    @pet = Pet.find(params[:id])
  end

  def correct_pet_user
    unless current_user == @user = Pet.find(params[:id]).user
      redirect_to root_url
    end
  end
  
  def pet_params
    params.require(:pet).permit(:name,:profile,:image,:remove_image,:user_id)
  end 
end
