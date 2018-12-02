class Profile < ApplicationRecord
  belongs_to :user
  
  #validates :battle_record, presence: true, length: { maximum: 255 },
                    #format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    #uniqueness: { case_sensitive: false }
  #validates :career, presence: true, length: { maximum: 255 },
                    #format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    #uniqueness: { case_sensitive: false }
  #mount_uploaders :image, ImageUploader
end
