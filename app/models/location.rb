class Location < ApplicationRecord
  validates :input_address, presence: true
end
