class Feature < ApplicationRecord
  
  has_many :points, dependent: :destroy

  is_json :meta_data
  
end
