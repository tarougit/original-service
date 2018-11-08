class Post < ApplicationRecord
  belongs_to :user
  
  has_many :relationships
  has_many :relationship_users, through: :relationships, source: :user
  
  validates :content, presence: true, length: { maximum: 255 }
end