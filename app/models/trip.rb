class Trip < ActiveRecord::Base
    has_many :itienaries
    belongs_to :category
    belongs_to :user
    belongs_to :merchant

    has_attached_file :picture,
        :styles => {
            original: { geometry: PPCLIP_APP_ORIGINAL },
            small:    { geometry: PPCLIP_APP_SMALL  },
            medium:   { geometry: PPCLIP_APP_MEDIUM },
            big:      { geometry: PPCLIP_APP_BIG    }
        }
        
    validates_attachment :picture, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
    validates :name, presence: true
    
    STATUS = %w( public private close )
                      
                      
end