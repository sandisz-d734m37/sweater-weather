class ApplicationController < ActionController::API
  def geo_locate
    @location = LocationFacade.get_location(params[:location])
  end
end
