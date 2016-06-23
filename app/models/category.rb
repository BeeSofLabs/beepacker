class Category < ActiveRecord::Base
  has_many :trips
  
  validates :name, presence: true  
end