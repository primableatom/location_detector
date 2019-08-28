class Point < ApplicationRecord 
  validates :latitude, :longitude, presence: true
  belongs_to :feature
end
