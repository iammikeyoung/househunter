class HousesController < ApplicationController

  def show
    @house = House.find(params[:id])
  end

  def new
    @house = House.new
  end

  def create
    @house = current_user.houses.build(house_params)
    if @house.save
      flash[:notice] = "House successfully added"
      redirect_to current_user
    else
      render :new
    end
  end

  private

    def house_params
      params.require(:house).permit(:name, :street, :city, :state, :zip_code,
                                    :asking_amount,
                                    :total_sqft,
                                    :photo)
    end

end
