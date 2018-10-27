class PostsController < ApplicationController
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
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = '募集が正常に投稿されました'
      redirect_to @post
    else
      flash.now[:danger] = '募集が投稿されませんでした'
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = '募集内容は正常に更新されました'
      redirect_to @post
    else
      flash.now[:danger] = '募集内容は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    flash[:success] = 'Message は正常に削除されました'
    redirect_to posts_url
  end
  
  private
  
  # Strong Parameter
  def post_params
    params.require(:post).permit(:sports, :title, :content, :event_date, :open, :closed, :due_date, :due_time, :erea, :place, :capacity, :cost, :level, :age_minimum, :age_maximum, :sex)
  end
end
