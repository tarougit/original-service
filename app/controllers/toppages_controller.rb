class ToppagesController < ApplicationController
  def index
    @posts = Post.all.page(params[:page]).per(3)
    @posts = @posts.where(area_id: params[:area_id].first) if params[:area_id]&.first.present?
    #@sports = Post.group(:sports).pluck(:sports).sort
    #@erea = Post.group(:erea).pluck(:erea).sort
    #@event_date = Post.group(:event_date).pluck(:event_date).sort
    #@level = Post.group(:level).pluck(:level).sort
  end
end