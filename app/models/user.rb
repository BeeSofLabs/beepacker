class User < ActiveRecord::Base
  has_many :social_networks
  has_many :outfits
  
  has_attached_file :avatar,
                    :styles => {
                        original: { geometry: PPCLIP_APP_ORIGINAL },
                        small:    { geometry: PPCLIP_APP_SMALL  },
                        medium:   { geometry: PPCLIP_APP_MEDIUM },
                        big:      { geometry: PPCLIP_APP_BIG    }
                    }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  
  before_create :generate_authentication_token
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  # reset password mechanism, using SecureRandom.hex(2) 4 alpha-numeric
  def self.generate_reset_token(email)

    user = User.find_by_email(email)
    raise 'not found' unless user
    
    # token = SecureRandom.hex(2) #
    token = %w(0 1 2 3 4 5 6 7 8 9).sample(4).join("")
    user.update(reset_token: token)
    return token
  end
  
  # for reset password
  def self.verified(token)
    begin
      user = ManualUser.find_by_reset_token(token)
      
      if user.present?
        user.update(reset_token: nil) # set nil if token accepted
        
        return user
        
      end
    rescue
      nil
    end
  end
  
  
  def self.update_info(auth, id)
    self.create do |user|
      user.username   = auth['name']
      user.avatar     = URI.parse(auth['image']) unless auth['image'].nil?
    end
  end
  

  private

  def generate_authentication_token
    token = SecureRandom.base64(64)
    user = User.find_by(authentication_token: token)
    return self.authentication_token = token unless user
    return token

  end

end
