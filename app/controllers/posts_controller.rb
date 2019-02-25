class PostsController < ApplicationController
  before_action :require_user_logged_in, only:[:show, :new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all
    #@sports = Post.group(:sports).pluck(:sports).sort
    #@erea = Post.group(:erea).pluck(:erea).sort
    #@event_date = Post.group(:event_date).pluck(:event_date).sort
    #@level = Post.group(:level).pluck(:level).sort
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
      @posts = current_user.feed_posts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = '募集の投稿に失敗しました。'
      render 'toppages/index'
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
      render 'toppages/index'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '募集を削除しました。'
    redirect_to posts_url
  end
  
  #def evaluated_posts
    #@user = User.find(params[:id])
    #@evaluated_posts = @user.post_users.relationship_posts(params[:post_id])
  #end
  
  def relation_users
    @post = Post.find(params[:id])
    @relation_users = @post.approved_users
  end
  
  #def search_posts #絞り込み検索機能
   # raise_errror
    
    #query_string = ""
    #if (params[:sports]  != "")
      #@posts = @posts.where("sports LIKE ? %#{params[:sports]}%")
    #end
    #@posts = Post.all.order("created_at DESC")
    #if (params[:erea] != "")
      #@posts = @posts.where('erea LIKE ?', "%#{params[:erea]}%")
    #end
    #if (params[:level] != "") 
      #@posts = @posts.where("level = #{params[:level]}")
    #end
    #if (query_string =~ /^ and /)
      #query_string = query_string.sub(/^and/, "")
    #end
    #@posts = Post.where("#{query_string}")
    #@sports = Post.group(:sports).pluck(:sports).sort
    #@erea = Post.group(:erea).pluck(:erea).sort
    #@event_date = Post.group(:event_date).pluck(:event_date).sort
    #@level = Post.group(:level).pluck(:level).sort
    #render :index
  #end
  
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
