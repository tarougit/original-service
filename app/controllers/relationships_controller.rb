class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    post = Post.find(params[:post_id])
    current_user.relationship(post)
    flash[:success] = '応募しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unrelationship(post)
    flash[:success] = '応募をキャンセルしました。'
    redirect_back(fallback_location: root_path)
  end
  
  def update
    @relation = Relationship.find(params[:id])

    if @relation.update(relationship_params)
      if (@relation.status == 1)
         flash[:success] = "承認しました。"
      else
         flash[:danger] = "拒否しました。"
      end
      redirect_back(fallback_location: root_url)
    else
      flash[:success] = "エラーが発生しました。"
      redirect_back(fallback_location: root_url)
    end
  end
  
  #def discontinue_post
    #post = Post.find(params[:post_id])
    #current_user.discontinue_post(post)
    #flash[:success] = '中止しました'
    #redirect_back(fallback_location: root_path)
  #end
  
  private
  
  # Strong Parameter
  def relationship_params
    params.require(:relationship).permit(:status)
  end
end
