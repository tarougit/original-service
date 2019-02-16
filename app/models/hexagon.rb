class Hexagon < ApplicationRecord
  belongs_to :user
  
  has_many :points
  has_many :points_users, through: :points, source: :user
end
