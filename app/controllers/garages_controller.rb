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
      @garage.levels.create(number: 1)
      redirect_to garage_path(@garage.id)
    else
      flash[:error] = "The garage could not be created because of: #{ @garage.errors.full_messages }"
      render :new
    end
  end

  def park_vehicle 
    
    @garage = Garage.find(params[:garage_id])

    if params[:park_button]
      if @garage.has_empty_lot?        
        @vehicle = new_vehicle_of_type

        if @vehicle.save 
          set_level_and_lot @garage, @vehicle
        else
          flash[:error] = "Vehicle cannot be parked because: #{ @vehicle.errors.full_messages }" 
        end

      else
        flash[:error] = "There is no room for this vehicle. Sorry." 
      end

    elsif params[:unpark_button]
      unpark_vehicle params, @garage
    end
      
    redirect_to garage_path @garage.id   
  end  

  def find_vehicle
    @garage = Garage.find(params[:garage_id])
    @vehicle = Vehicle.find_by(plate: params[:plate])
    
    if @vehicle
      flash[:notice] = "The vehicle with plate #{ @vehicle.plate }, is in level: #{ @vehicle.level.number }, lot: #{ @vehicle.lot.number }"
    else
      flash[:error] = "There is no vehicle in this garage with the submited plate: #{ params[:plate] }"
    end  

    redirect_to garage_path @garage.id  

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

  def set_level_and_lot garage, vehicle

    if garage.create_new_level?
      level_number = garage.levels.last.number + 1
      garage.levels.create(number: level_number)
    end

    lot_number = if Lot.count == 0 
                   1
                 else
                   Lot.last.number + 1 
                 end 

    lot = Lot.create(garage_id: garage.id, vehicle_id: vehicle.id, level_id: garage.levels.last.id, number: lot_number)    
    vehicle.update_attributes(garage_id: garage.id, lot_id: lot.id, level_id: garage.levels.last.id)
    
    flash[:error] = "The vehicle has been succesfully parked in level: #{ vehicle.level.number }, lot: #{ vehicle.lot.number }."  
  end

  def unpark_vehicle params, garage
    vehicle = Vehicle.find_by(plate: params[:plate])

    if vehicle
      lot = Lot.find_by(vehicle_id: vehicle.id)
      lot.destroy

      vehicle.destroy

      if garage.delete_level?
        garage.levels.last.delete
      end        

      flash[:notice] = "The #{ params[:type] } with plate: #{ params[:plate] }, has left the garage"
    else
      flash[:error] = "There is no vehicle in this garage with the submited plate: #{ params[:plate] }"
    end               
  end  
end