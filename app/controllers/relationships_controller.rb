class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    post = Post.find(params[:post_id])
    current_user.relationship(post)
    flash[:success] = '応募しました。マイページの「応募管理」で、投稿者からの「承認」を確認して参加してください。'
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
         flash[:success] = "参加を承認しました。"
      else
         flash[:danger] = "参加を拒否しました。"
      end
      redirect_back(fallback_location: root_url)
    else
      flash[:success] = "エラーが発生しました。"
      redirect_back(fallback_location: root_url)
    end
  end
  
  private
  
  # Strong Parameter
  def relationship_params
    params.require(:relationship).permit(:status)
  end
end
