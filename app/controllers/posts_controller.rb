class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '募集を投稿しました。'
      redirect_to root_url
    else
      @posts = current_user.posts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = '募集の投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @posts = current_user.posts.find(params[:id])

    if @post.update(post_params)
      flash[:success] = '募集内容は正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = '募集内容は更新されませんでした'
      render 'toppages/index'
    end
  end

  def destroy
     @post.destroy
    flash[:success] = '募集を削除しました。'
    redirect_to posts_url
  end
  
  private
  
  # Strong Parameter
  def post_params
    params.require(:post).permit(:sports, :title, :content, :event_date, :open, :closed, :due_date, :due_time, :erea, :place, :capacity, :cost, :level, :age_minimum, :age_maximum, :sex)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
