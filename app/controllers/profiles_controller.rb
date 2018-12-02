class ProfilesController < ApplicationController
  # :require_logged_in, :profile_completed?
  before_action :require_user_logged_in, only: [:show, :new, :create, :edit, :update]
  
  def show
    @profile = Profile.find(params[:user_id])
  end

  def new
    @user = User.find(params[:user_id])
    @profile = current_user.build_profile
  end

  def create
    @user = User.find(params[:user_id])
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      flash[:success] = 'プロフィールを設定しました'
      redirect_to @user
    else
      flash.now[:danger] = 'プロフィールの設定に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def update
    @user = User.find(params[:user_id])
    @profile = @user.profile

    if @profile.update(profile_params)
      flash[:success] = 'プロフィールを変更しました'
      redirect_to @user
    else
      flash.now[:danger] = 'プロフィールの変更に失敗しました。'
      render :new
    end
  end
  
  
  private

  def profile_params
    params.require(:profile).permit(:icon, :active_area, :sex, :birthday, :sports, :level, :battle_record, :career, :image)
  end
end