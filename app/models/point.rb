class Point < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :hexagon
end