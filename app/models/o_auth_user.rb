class OAuthUser
  attr_reader :provider, :user

  def initialize params, user = nil
    @auth = params
    @user = user
    @provider = @auth['provider']
    @uid = @auth['uid']
    # @policy = "#{@provider}_policy".classify.constantize.new(@auth)
  end

  def login_or_create
    create_new_account
  end

  def create_new_account
    unless @user.social_networks.exists?(provider: @provider, uid: @uid)
      @account = @user.social_networks.create!(
        :provider => @provider,
        :uid      => @uid
      )
      User.update_info(@auth, @user.id)
    end
  end
end
