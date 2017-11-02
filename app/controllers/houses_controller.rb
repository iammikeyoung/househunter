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

  def edit
    @house = House.find(params[:id])
  end

  def update
    @house = House.find_by(id: params[:id])
    if @house.update_attributes(house_params)
      flash[:notice] = "House successfully updated"
      redirect_to current_user
    else
      render 'edit'
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
