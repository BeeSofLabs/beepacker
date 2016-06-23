class API::V1::PromoSerializer < API::BaseSerializer
  attributes :title, :content, :picture_small, :picture_medium, :lat, :lng, :visitor_count
  
  
  def picture_small
    object.picture.url(:small)
  end
  
  def picture_medium
    object.picture.url(:medium)
  end
  
end
