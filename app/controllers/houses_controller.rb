class HousesController < ApplicationController
  before_action :logged_in_user,  only: [:show, :edit, :update, :destroy]
  before_action :correct_user,    only: [:show, :edit, :update, :destroy]

  def show
    @house = House.find(params[:id])
    @notes = @house.notes
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

  def destroy
    House.find(params[:id]).destroy
    flash[:notice] = "House deleted"
    redirect_to current_user
  end

  private

    def house_params
      params.require(:house).permit(:name, :street, :city, :state, :zip_code,
                                    :asking_amount,
                                    :total_sqft,
                                    :house_profile_pic)
    end

    # Before filters

    # Confirms a logged-in user
    def logged_in_user
      unless logged_in?
        flash[:notice] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @house = House.find(params[:id])
      @user = @house.user
      unless current_user?(@user)
        flash[:notice] = "Unauthorized access."
        redirect_to(root_path)
      end
    end
end
