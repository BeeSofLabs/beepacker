class Transaction < ActiveRecord::Base
  
  has_attached_file :bill_picture,
      :styles => {
          original: { geometry: PPCLIP_APP_ORIGINAL },
          small:    { geometry: PPCLIP_APP_SMALL  },
          medium:   { geometry: PPCLIP_APP_MEDIUM },
          big:      { geometry: PPCLIP_APP_BIG    }
      }
      
  validates_attachment :bill_picture, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates :code, presence: true
  validates :name, presence: true
  validates :buyer, presence: true
  validates :owner, presence: true
  
end