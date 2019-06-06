class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :posts
  has_many :relationships, dependent: :destroy
  has_many :relationship_posts, through: :relationships, source: :post
  #has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'post_user_id'
  #has_many :reserves, through: :reverses_of_relationship, source: :user
  
  #has_one :profile
  
  #has_one :hexagon
  
  has_many :points, dependent: :destroy
  #has_many :statuses, ->{where('relationships.status' => 1)}
  
  def relationship(other_post)
    self.relationships.find_or_create_by(post_id: other_post.id)
  end
  
  def unrelationship(other_post)
    relationship = self.relationships.find_by(post_id: other_post.id)
    relationship.destroy if relationship
  end
  
  def relationship?(other_post)
    self.relationship_posts.include?(other_post)
  end
  
  #=> #<ActiveRecord::Relation
  # [#<Point id: 1, post_id: 16, user_id: 1, evaluated_user_id: 6, hexagon_id: 1, created_at: "2018-12-05 12:06:58", updated_at: "2018-12-05 12:06:58">]> 

  def has_make_point?(post)
    
    if (Point.where(post_id: post.id).find_by(evaluate_user_id: self.id))
      return true
    else
      return false
    end
  end
  
  def has_status?(post)
    relationship = post.relationships.find_by(user_id: self.id)
    if (relationship != nil && relationship.status == 1)
      return true
    else
      return false
    end
  end
  
  enum state: { release: 1, privacy: 2, unsubscribe: 3 }
end