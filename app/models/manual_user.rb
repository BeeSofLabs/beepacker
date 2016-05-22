class ManualUser < User
  ## Validations
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :password_confirmation, presence: true, if: '!password.nil?'
  
  DEFAULT_PASSWORD = "123456789"
end
