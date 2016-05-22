class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :authenticate_user!, only: [ :create, :reset, :verify ]

  def create
    user = ManualUser.new(create_params)
    begin

      user.save!
      render(
        json: API::V1::UserSerializer.new(user, extra: true).to_json,
        status: 200
      )
    rescue
      return api_error(status: 500, errors: user.errors.to_a.join(", "))
    end
  end

  def update
    update_params_instance = update_params.reject { |k,v| k == "avatar" }

    if @current_user.update(update_params_instance)

      if params[:user][:avatar]

        @current_user.update({
          avatar: decode_picture_data(params[:user][:avatar])
        })
      end

      render(
        json: API::V1::UserSerializer.new(@current_user, extra: true).to_json,
        status: 200
      )
    else
      return api_error(status: 500, errors: @current_user.errors.to_a.join(", ") )
    end
  end


  def reset
    email = params[:email]

    if email.present? && User.find_by_email(email).present?

      token = User.generate_reset_token(email)

      ## send email to user for reset password with token as a content
      UserMailer.reset_password(email, token).deliver_now  

      render( json: { passcode: token}.to_json, status: 200 )
    else
      return api_error(status: 500, errors: "Email Not valid!")
    end
  end


  def verify
    token = params[:token]
    user = User.verified(token)
    if user
      user.update(password: ManualUser::DEFAULT_PASSWORD, password_confirmation: ManualUser::DEFAULT_PASSWORD)
      if user.authenticate(ManualUser::DEFAULT_PASSWORD)
        user.update(authentication_token: user.send(:generate_authentication_token)) if user.authentication_token.nil?

        render(
          json: API::V1::UserSerializer.new(user, extra: true, message: t("verified_password")).to_json,
          status: 200
        )

      else
        return api_error(status: 500, errors: "Wrong credentials")
      end
    else
      return api_error(status: 500, errors: "Wrong Token" )
    end

  end

  private

  def create_params
    params.require(:user).permit(
      :email, :full_name, :password, :password_confirmation
    ).delete_if { |k,v| v.nil? }
  end

  def update_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :full_name, :username, :first_name, :last_name, :avatar,:skin_tone, :body_shape, :body_height, :gender
    )
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