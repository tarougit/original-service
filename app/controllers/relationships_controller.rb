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
    flash[:success] = 'キャンセルしました。'
    redirect_back(fallback_location: root_path)
  end
end
