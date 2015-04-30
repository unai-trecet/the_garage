class VehiclesController < ApplicationController

  def create
    if params[:type] == "car"
      @vehicle = Car.new(plate: params[:plate])
    else
      @vehicle = Motorbike.new(plate: params[:plate])
    end

    flash[:error] = "License plate must be submited." unless @vehicle.save

    render "garages/show"
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:plate, :type)
  end
end