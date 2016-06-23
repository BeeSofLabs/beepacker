class API::V1::TripSerializer < API::BaseSerializer
  attributes :id, :name, :price, :currency, :start_date, :end_date, :picture_small, :status

      
  def attributes(*args)
    hash = super    
    if @extra
      hash[:picture_medium] = picture_medium
    end

    if @message
      hash[:message]  = @message
    end
    
    hash
  end
  
  
  def picture_small
    object.picture.url(:small)
  end
  
  def picture_medium
    object.picture.url(:medium)
  end
  
end
