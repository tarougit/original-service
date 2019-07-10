class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :relationships, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
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
    @user = User.new(state: :release)
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
    @user = User.find(params[:id])

    if params[:state].present?
      @user.state = params[:state].to_i
      @user.save
      flash[:success] = '登録が復活しました。'
      redirect_to @user
    elsif @user.update(user_params)
      flash[:success] = 'ユーザを更新しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの編集に失敗しました。'
      render :new
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    
    #@user.profile.destroy if @user.profile
    # @user.relationships.destroy_all if @user.relationships.any?
      #@user.delete
      @user.update(state: :unsubscribe)
      flash[:success] = '退会しました'
      redirect_to @user
  end
  
  def post_users #募集投稿
    @user = User.find(params[:id])
    @post_users = @user.posts
    @post_users = @post_users.map{|o| o if o.event_date > (Date.current - 1) }.compact
  end
  
  def relationship_posts #応 募
    @user = User.find(params[:id])
    @relationship_posts = @user.relationship_posts.page(params[:page])
    @relationship_posts = @relationship_posts.map{|o| o if o.event_date > (Date.current - 7) }.compact
  end
  
  #def profile #プロフィール設定
    #@user = User.find(params[:id])
    #@profile = @user.build_profile
  #end
  
  def finished_posts #開催されたイベント(募集、応募 両方表示できるようにする)
    @user = User.find(params[:id])
    @posts = @user.posts + @user.relationship_posts.includes(:relationships).where(relationships: {status: 1})
    @posts = @posts.map{|o| o if o.event_date > (Date.current - 7) && o.event_date < Date.current }.compact
  end
  
  #def finished_posts #開催されたイベント(募集、応募 両方表示する)
    #@user = User.find(params[:id])
    #user_posts = @user.relationship_posts
    #current_user_posts = current_user.relationship_posts
    #post_ids = []
    #user_posts.each do |post|
      #post_ids << post.id if current_user_posts.include?(post)
    #end
    #@posts = Post.where(id: post_ids)
  #end
  
  def finished_users #評価対象の参加者一覧
    @user = User.find(params[:id])
    
    @post = Post.find(params[:post_id])
    # @post = Post.where(@user, :status, value: user.ids)
    @finished_users = @post.approved_users.where.not(id: current_user.id)
  end
  
  def post_evaluate #私が評価する参加者
    @user = User.find(params[:id])
    @post = Post.find(params[:post_id])
    @hexagons = Hexagon.all
    @post_evaluate = @post.approved_users
  end
  
  def make_evaluate
    @ev_kind = params[:evaluate][:point]
    @post = Post.find(params[:post_id])
    
    @user = User.find(params[:id])
    
    if (current_user.has_make_point?(@post))
      flash[:alert] = "既に評価済みです。"
      redirect_back(fallback_location: root_url)
      return
    end
    
    if ((@user == current_user) ||
       (@post.event_date.since(7.days) < Time.now ) ||
       (@post.event_date > Time.now ))
      flash[:alert] = "評価できません。"
      redirect_back(fallback_location: root_url)
      return       
    end
    
    if ((@user == current_user) ||
       (@post.closed > Time.now))
      flash[:alart] = "まだ評価できません。"
      redirect_back(fallback_location: root_url)
      return
    end
    # current_user postにおいて既にpoint付与済みかどうか？
    # post 7日以内か？
    

     p =  @user.points.build(evaluate_user_id: current_user.id,
                      hexagon_id: @ev_kind, post_id: @post.id)
     p.save

    #end
    redirect_to current_user
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
