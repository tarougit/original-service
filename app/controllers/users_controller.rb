class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :relationships, :destroy]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC').page(params[:page])
    
    summaries = @user.points.group(:hexagon_id).count(:hexagon_id)
    
    ## {1=>2, 4=>1, 5=>2} 
    
    @summary_data = []
    (1..6).each do |key|
      if summaries[key] 
        @summary_data[key - 1] = summaries[key]
      else
        @summary_data[key - 1] = 0
      end
    end
 
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
  
  def post_users #募集投稿
    @user = User.find(params[:id])
    #@relationships = Relationship.users.page(params[:page])
    @post_users = @user.posts
    #counts(@relationship)
  end
  
  def relationship_posts #応 募
    @user = User.find(params[:id])
    @relationship_posts = @user.relationship_posts.page(params[:page])
  end
  
  def profile #プロフィール設定
    @user = User.find(params[:id])
    @profile = @user.build_profile
  end
  
  def finished_posts #開催されたイベント(募集、応募 両方表示する)
    @user = User.find(params[:id])
    user_posts = @user.relationship_posts
    current_user_posts = current_user.relationship_posts
    post_ids = []
    user_posts.each do |post|
      post_ids << post.id if current_user_posts.include?(post)
    end
    @posts = Post.where(id: post_ids)
  end
  
  def finished_users #評価対象の参加者一覧
    @user = User.find(params[:id])
    @post = Post.where(@user, :status, value: user.ids)
    @finished_users = @post.finished_users
  end
  
  def post_evaluate #評価する参加者
    @user = User.find(params[:id])
    @post = Post.find(params[:post_id])
    @hexagons = Hexagon.all
  end
  
  def make_evaluate
    @ev_kind = params[:evaluate][:point]
    @post = Post.find(params[:post_id])
    
    @user = User.find(params[:id])
    
    #if ((@user != current_user) &&
    #   (post.eventdate.since(7.days) > Time.now ) &&
    #   (!current_user.has_make_point?(@post)))
    # current_user postにおいて既にpoint付与済みかどうか？
    # post 7日以内か？
    
       p =  @user.points.build(evaluated_user_id: current_user.id,
                        hexagon_id: @ev_kind, post_id: @post.id)
       p.save
    #end
    redirect_to @user
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
