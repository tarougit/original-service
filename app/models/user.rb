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
  
  def relationship(other_post)
    self.relationships.find_or_create_by(post_id: other_post.id)
  end
  
  def unrelationship(other_post)
    relationship = self.relationships.find_by(post_id: other_post.id)
    relationship.destroy if relationship
  end
  
  def relationship?(other_post)
    self.relationships.include?(other_post)
  end
  
  def feed_relationship_posts
    Relationship_post.where(post_id: self.relationship_ids + [self.id])
  end
end
