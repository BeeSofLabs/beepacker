class Itienary < ActiveRecord::Base
  belongs_to :trip
  has_many :images, as: :imageable
  
  validates :title, presence: true  
  
  after_save :update_image_count
  
  
  
  
  def update_image_count
    self.image_count = self.images.size
  end
  
  
end