class Api::V1::PromosController < Api::V1::ApiController
  skip_before_filter :authenticate_user!
  
  def index
    begin
      render(json: Promo.all, each_serializer: API::V1::PromoSerializer, status: 200)
      
    rescue
      return api_error(status: 400, errors: "Not Found")
    end
  end
end