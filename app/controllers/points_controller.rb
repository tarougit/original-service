class PointsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @ev_kind = params[:evaluate][:point]
    @user = User.find(params[:id])
    @post = Post.find(params[:post_id])
    current_user.point(evaluated_user_id: current_user_id,
                       hexagon_id: @ev_kind, post_id: @post.id)
  end
end
