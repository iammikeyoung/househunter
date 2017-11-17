class NotesController < ApplicationController

  def show
    @note = Note.find(params[:id])
    @house = @note.house
  end

  def new
    @house = House.find(params[:house_id])
    @note = Note.new
  end

  def create
    @house = House.find(params[:house_id])
    @note = @house.notes.build(note_params) # is there a way to include user_id in this?
    @note.user = current_user
    if @note.save
      flash[:notice] = "Note successfully added!"
      redirect_to @house
    else
      render :new
    end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      flash[:notice] = "Note successfully updated"
      redirect_to @note
    else
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @house = @note.house
    @note.destroy
    flash[:notice] = "Note successfully deleted"
    redirect_to @house
  end

  private
    def note_params
      params.require(:note).permit(:room, :rating, :pros, :cons)
    end

end
