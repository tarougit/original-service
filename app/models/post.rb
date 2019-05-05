class Post < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :user
    
  has_many :relationships
  has_many :users, through: :relationships, source: :user
  
  has_many :approved_users, ->{where('relationships.status' => 1)}, through: :relationships, source: :user
  has_many :nonapproved_users, ->{where('relationships.status' => 0)}, through: :relationships, source: :user

  validates :content, presence: true, length: { maximum: 255 }


   def has_approved?(user)
     self.approved_users.include?(user)
   end
   
   
   #def has_apply?(user)
     #self.users.include?(user)
   #end
end