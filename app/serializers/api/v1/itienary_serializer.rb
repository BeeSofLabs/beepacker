class API::V1::ItienarySerializer < API::BaseSerializer
  attributes :id, :title, :content, :transportation, 
          :location, :lat, :lng, :image_count, :start_date, :photo_small, :trip_id

      
  def attributes(*args)
    hash = super    
    if @extra
      hash[:photo_medium] = photo_medium
    end

    if @message
      hash[:message]  = @message
    end
    
    hash
  end
  
  
  def photo_small
    (object.images.size > 0) ? object.images.last.photo.url(:small) : ""
  end
  
  def photo_medium
    return object.images.last.photo.url(:medium) if object.images.size > 0
    return ""
  end
  
end
