class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  
  has_attached_file :photo,
    :styles => {

        small:  { geometry: PPCLIP_APP_SMALL  },
        medium: { geometry: PPCLIP_APP_MEDIUM },
        big:    { geometry: PPCLIP_APP_BIG    }
    
    },
    :default_url => :default_photo_url,
    :processors => [:thumbnail]

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end