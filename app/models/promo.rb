class Promo < ActiveRecord::Base

  
  has_attached_file :picture,
      :styles => {
          original: { geometry: PPCLIP_APP_ORIGINAL },
          small:    { geometry: PPCLIP_APP_SMALL  },
          medium:   { geometry: PPCLIP_APP_MEDIUM },
          big:      { geometry: PPCLIP_APP_BIG    }
      }
      
  validates_attachment :picture, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates :title, presence: true
  validates :content, presence: true
  validates :promotype, presence: true
  
  STATUS  = %w(show hide)
  TYPE    = %w(general ecommerce travel transportation food)
end