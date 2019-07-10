class Post < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :user
  belongs_to :area
    
  has_many :relationships
  has_many :users, through: :relationships, source: :user
  
  has_many :approved_users, ->{where('relationships.status' => 1)}, through: :relationships, source: :user
  has_many :nonapproved_users, ->{where('relationships.status' => 0)}, through: :relationships, source: :user

  validates :content, presence: true, length: { maximum: 255 }


   def has_approved?(user)
     self.approved_users.include?(user)
   end
   
  def same_date?
    self.due_date.in_time_zone == Time.zone.now.to_date.in_time_zone
  end
  
  def date_yet?
    self.due_date.in_time_zone > Time.zone.now.to_date.in_time_zone
  end
  
  def time_yet?
    to_minit(self.due_time)  >= to_minit(Time.current)
  end

  private
  
  def to_minit(time)
    time_ary = time.to_s(:time).split(":").map(&:to_i)
    time_ary[0] * 60 + time_ary[1]
  end
end