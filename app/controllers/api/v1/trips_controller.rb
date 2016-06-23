class Api::V1::TripsController < Api::V1::ApiController
  skip_before_filter :authenticate_user!
  
  def index
    begin
      render(
        json: Trip.all, each_serializer: API::V1::TripSerializer, status: 200
      )
      
    rescue
      return api_error(status: 400, errors: "Not Found")
    end
  end
  
  def show
    begin
      trip = Trip.find(params[:id])
    
      render(
        json: API::V1::TripSerializer.new(trip).to_json,
        status: 200
      )
    rescue
      return api_error(status: 400, errors: "Not found")
    end
  end
  
  def create
    
    begin
      trip = Trip.create(create_params)

      render(
        json: API::V1::TripSerializer.new(trip).to_json,
        status: 200
      )
      
    rescue
      return api_error(status: 400, errors: "Saved failed!")
    end
    
  end
  
  def update
    update_params_instance = update_params.reject { |k,v| k == "picture" }
    
    trip = Trip.find(params[:id])
    trip.update(update_params_instance)
    
    if params[:trip][:avatar]

      trip.update({
        picture: decode_picture_data(params[:user][:picture])
      })
    end
    
    render(
      json: API::V1::TripSerializer.new(trip).to_json,
      status: 200
    )
    
  end
  
  def destroy
    trip = Trip.find(params[:id])
    trip.destroy
    
    render json: { message: "Ok" }, status: 200
    
  end
  
  
  private

  def create_params
    params.require(:trip).permit(
      :name, :price, :currency, :start_date, :end_date
    ).delete_if { |k,v| v.nil? }
  end
  
  def update_params
    params.require(:trip).permit(
      :name, :price, :currency, :start_date, :end_date, :picture
    ).delete_if { |k,v| v.nil? }
  end
end