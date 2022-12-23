# frozen_string_literal: true

# class for working with hotels
class HotelsController < ApplicationController
  before_action :set_hotel, only: %i[show edit update destroy]
  skip_before_action :authenticate, only: [:index]
  skip_before_action :authenticate_as_admin, only: %i[show index]

  # GET /hotels or /hotels.json
  def index
    @hotels = Hotel.all
  end

  # GET /hotels/1 or /hotels/1.json
  def show
    @hotel_rooms = Room.all.select { |room| room.hotel.id == @hotel.id }
  end

  # GET /hotels/new
  def new
    @hotel = Hotel.new
  end

  # GET /hotels/1/edit
  def edit; end

  # POST /hotels or /hotels.json
  def create
    @hotel = Hotel.new(hotel_params)

    respond_to do |format|
      if @hotel.save
        format.html { redirect_to hotel_url(@hotel) }
      else
        format.html { redirect_to new_hotel_path(errors: @hotel.errors.full_messages) }
      end
    end
  end

  # PATCH/PUT /hotels/1 or /hotels/1.json
  def update
    respond_to do |format|
      if @hotel.update(hotel_params)
        format.html { redirect_to hotel_url(@hotel) }
      else
        format.html { redirect_to new_hotel_path(errors: @hotel.errors.full_messages) }
      end
    end
  end

  # DELETE /hotels/1 or /hotels/1.json
  def destroy
    @hotel.destroy

    respond_to do |format|
      format.html { redirect_to hotels_url, notice: 'Hotel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def hotel_params
    params.require(:hotel).permit(:location, :name, :description, :image)
  end
end
