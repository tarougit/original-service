class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validate :check_post_user
  
  def check_post_user
    if self.user == self.post.user
      errors.add(:post_id, "自分の投稿には申し込めません")
    end
  end
end
