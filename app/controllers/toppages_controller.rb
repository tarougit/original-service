class ToppagesController < ApplicationController
  def index
    @posts = Post.all
    #@sports = Post.group(:sports).pluck(:sports).sort
    #@erea = Post.group(:erea).pluck(:erea).sort
    #@event_date = Post.group(:event_date).pluck(:event_date).sort
    #@level = Post.group(:level).pluck(:level).sort
  end
end