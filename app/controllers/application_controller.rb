class ApplicationController < ActionController::Base
  #before_action :require_logged_in, :profile_completed?
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  def counts(user)
    @count_posts = user.posts.count
    @count_relationship_posts = user.relationship_posts.count
  end
  
  #def profile_completed?
    #if current_user.profile.valid?
      #flash[:info] = I18n.t('labels.users.complete_profile_please')
      #redirect_to edit_user_profile_url
    #end
  #end
  
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
