class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    user = User.find(params[:post_id])
    current_user.relationship(post)
    flash[:success] = '応募しました。'
    redirect_to user
  end

  def destroy
    user = User.find(params[:post_id])
    current_user.unrelationship(post)
    flash[:success] = 'キャンセルしました。'
    redirect_to user
  end
end
