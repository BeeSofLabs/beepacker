class API::V1::UserSerializer < API::BaseSerializer
  attributes :id, :email, :gender, :authentication_token

      
  def attributes(*args)
    hash = super    
    if @extra
      hash[:username]       = object.username
      hash[:first_name]     = object.first_name
      hash[:last_name]      = object.last_name      
      hash[:full_name]      = object.full_name
      hash[:avatar]         = object.avatar
      hash[:avatar_small]   = avatar_small
      hash[:avatar_medium]  = avatar_medium
    end
    
    

    if @message
      hash[:message]  = @message
    end
    
    hash
  end
  
  
  def avatar_small
    object.avatar.url(:small)
  end
  
  def avatar_medium
    object.avatar.url(:medium)
  end
  
end
