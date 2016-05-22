class Api::V1::OmniauthsController < Api::V1::ApiController
  skip_before_action :authenticate_user!, only: [ :create ]

  def create
    
    user = User.find_or_create_by(email: signup_params[:email])
    if user.update(user_params)
      user.send(:generate_authentication_token) if user.authentication_token.nil?
      OAuthUser.new(signup_params, user).login_or_create
      render(
        json: API::V1::UserSerializer.new(user, extra: true).to_json,
        status: 200
      )
    else
      return api_error(status: 500, errors: "Wrong credentials" )
    end
  end

  private

  def signup_params
    params.require(:user).permit(
      :email, :full_name, :provider, :uid, :avatar
    ).delete_if { |k,v| v.nil? }
  end
  
  def user_params
    params.require(:user).permit(:email, :full_name).delete_if { |k,v| v.nil? }
  end
end
