class GaragesController < ApplicationController
  def new
    @garage = Garage.new
  end

  def create
    @garage = Garage.new(garage_params)

    if @garage.save 
      redirect_to garage_path(@garage.id)
    else
      flash[:error] = "The garage could not be created because of: #{ @garage.errors.full_messages }"
      render :new
    end
  end

  private

  def garage_params
    params.require(:garage).permit(:levels, :lots)
  end
end