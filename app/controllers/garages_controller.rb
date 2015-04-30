class GaragesController < ApplicationController
  
  def show
    @garage = Garage.find(params[:id])
  end

  def new
    @garage = Garage.new
  end

  def create

    @garage = Garage.new(garage_params)

    if @garage.save 
      @garage.levels.create()
      redirect_to garage_path(@garage.id)
    else
      flash[:error] = "The garage could not be created because of: #{ @garage.errors.full_messages }"
      render :new
    end
  end

  def park_vehicle 
    
    @garage = Garage.find(params[:garage_id])
   
   
    if @garage.has_empty_lot?
      
      @vehicle = new_vehicle_of_type

      if @vehicle.save 
        if @garage.create_new_level?
          @garage.levels.create()
        end

        @lot = Lot.create(garage_id: @garage.id, vehicle_id: @vehicle.id, level_id: @garage.levels.last.id)
        @vehicle.update_attributes(garage_id: @garage.id, lot_id: @lot.id, level_id: @garage.levels.last.id)
        
        flash[:error] = "The #{ params[:type] } has been succesfully parked in level: #{ @vehicle.level.id }, lot: #{ @vehicle.lot.id }."
      else
        flash[:error] = "Vehicle cannot be parked because: #{ @vehicle.errors.full_messages }" 
      end

    else
      flash[:error] = "There is no room for this vehicle. Sorry." 
    end

    render :show   
  end  

  private

  def garage_params
    params.require(:garage).permit(:number_levels, :number_lots)
  end

  def new_vehicle_of_type
    if params[:type] == "car"
      Car.new(plate: params[:plate])
    else
      Motorbike.new(plate: params[:plate])
    end    
  end
end