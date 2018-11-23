class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  def counts(user)
    @count_posts = user.posts.count
    @count_relationship_posts = user.relationship_posts.count
  end
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    #@count_posts = user.posts.count
  end
end
