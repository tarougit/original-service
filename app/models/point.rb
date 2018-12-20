class Point < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :evaluated_user, class_name: 'User'
  belongs_to :hexagon
end
