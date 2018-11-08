class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :relationships, :destroy]
  
  def index
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
    @user = User.find(params[:id])
      @user.delete
      flash[:success] = '退会しました'
      redirect_to root_url
  end
  
  def relationships
    @user = User.find(params[:id])
    @relationship = @user.relationships.page(params[:page])
    counts(@relationship)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
