class ToppagesController < ApplicationController
  def index
    if logged_in?
      @post = current_user.posts.build(sports: nil, title: nil, content: nil, event_date: nil, open: nil, closed: nil, due_date: nil, due_time: nil, erea: nil, place: nil, capacity: nil, cost: nil, level: nil, age_minimum: nil, age_maximum: nil, sex: nil, status: 0)
      @posts = current_user.posts.order('created_at DESC').page(params[:page])
    end
  end
end
