class HousesController < ApplicationController

  def show
    @house = House.find(params[:id])
  end

  def new
    @house = House.new
  end

  def create
    @house = current_user.houses.build(house_params)
  end

end
