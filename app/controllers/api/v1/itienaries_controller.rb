class Api::V1::ItienariesController < Api::V1::ApiController
  
  def index
    begin
      trip = Trip.find(params[:trip_id])
      render(
        json: trip.itienaries, each_serializer: API::V1::ItienarySerializer, status: 200
      )
      
    rescue
      return api_error(status: 400, errors: "Not Found")
    end
  end
  
  def show
    begin
      itienary = Itienary.find(params[:id])
    
      render(
        json: API::V1::ItienarySerializer.new(itienary).to_json,
        status: 200
      )
    rescue
      return api_error(status: 400, errors: "Not found")
    end
  end
  
  def create
    
    begin
      itienary = Itienary.create(itienary_params)

      if params[:itienary][:image_photo]
        image = Image.create(
                      photo: decode_picture_data(params[:itienary][:image_photo]), 
                      alt: params[:image_alt], 
                      name: params[:image_name])

        itienary.images << image
      end
      
      render(
        json: API::V1::ItienarySerializer.new(itienary).to_json,
        status: 200
      )
      
    rescue
      return api_error(status: 400, errors: "Saved failed!")
    end
    
  end
  
  def update    
    itienary = Itienary.find(params[:id])
    
    if params[:itienary][:image_photo]
      image = Image.create(
                    photo: decode_picture_data(params[:itienary][:image_photo]), 
                    alt: params[:image_alt], 
                    name: params[:image_name])
                    
      itienary.images << image
    end
    
    itienary.update(itienary_params)
    
    render(
      json: API::V1::ItienarySerializer.new(itienary).to_json,
      status: 200
    )
    
  end
  
  # def destroy
  #   trip = Itienary.find(params[:id])
  #   trip.destroy
  #   
  #   render json: { message: "Ok" }, status: 200
  #   
  # end
  
  
  private

  def itienary_params
    params.require(:itienary).permit(
      :title, :content, :transportation, :location, :lat, :lng, :start_date, :end_date
    ).delete_if { |k,v| v.nil? }
  end
  
end