class PetsController < ApplicationController
  
    before_action :require_user_logged_in 
    before_action :dry_user_params, except: [:update]
    before_action :correct_user, except: [:index]

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
  end
  
  private
  
  def dry_user_params
    @user = User.find(params[:user_id])
  end
  
  def dry_pet_params
    @pet = @user.pets.find(params[:id])
  end
  
  
  def pet_params
    params.require(:pet).permit(:name,:profile,:image,:user_id)
  end 
end
