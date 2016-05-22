class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :authenticate_user!, only: [ :create ]

  def create
    begin
      if user = ManualUser.find_by(email: create_params[:email])

        if user.authenticate(create_params[:password])
          user.update(authentication_token: user.send(:generate_authentication_token)) if user.authentication_token.nil?

          render(
            json: API::V1::UserSerializer.new(user, extra: true).to_json,
            status: 200
          )

        else
          return invalid_resource!('Wrong credentials')
        end

      else
        return invalid_resource!('No user found')
      end
    rescue
      invalid_resource!('Wrong credentials' )
    end
  end

  def destroy
    if @current_user
      @current_user.update(authentication_token: nil)
      render(
        json: API::V1::UserSerializer.new(@current_user, extra: true).to_json,
        status: 200
      )
    else
      return invalid_resource!(status: 500, errors: 'No user found')
    end
  end


  private

  def create_params
    params.require(:session).permit(
      :email, :password
    ).delete_if { |k,v| v.nil? }
  end
end