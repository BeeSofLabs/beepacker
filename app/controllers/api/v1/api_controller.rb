class Api::V1::ApiController < ActionController::Base
  protect_from_forgery with: :null_session,
    only: Proc.new { |c| c.request.format.json? }
  skip_before_filter :verify_authenticity_token

  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :not_found!

  attr_accessor :current_user

  protected

  def unauthenticated!
    response.headers['WWW-Authenticate'] = "Token realm=Application"
    render json: { error: 'Bad credentials' }, status: 401
  end

  def invalid_resource!(errors = [])
    api_error(status: 500, errors: errors)
  end

  def not_found!
    api_error(status: 400, errors: 'Not found')
  end

  def api_error(status: 500, errors: [])
    unless Rails.env.production?
      puts errors.full_messages if errors.respond_to? :full_messages
    end
    head status: status and return if errors.empty?

    render json: { error: errors }, status: status
  end

  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    user_email = options.blank? ? nil : options[:email]
    user = user_email && ManualUser.find_by(email: user_email)
    user = User.find_by(email: user_email) if user.social_networks.present?

    if user && user.authentication_token && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
      @current_user = user
    else
      return unauthenticated!
    end
  end
  
  
  
  def decode_picture_data(image64)
      # remove `data:image/jpeg;base64,`
      image64.gsub!(/^(.*base64,)/i, '')
      # decode the base64
      data = StringIO.new(Base64.decode64(image64))

      # assign some attributes for carrierwave processing
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = "#{SecureRandom.hex(5)}.png"
      data.content_type = "image/png"

      # return decoded data
      data
  end
end