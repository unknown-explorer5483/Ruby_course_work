# frozen_string_literal: true

# class for working with rooms
class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy]
  skip_before_action :authenticate_as_admin, only: %i[show book unbook]

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show; end

  # GET /rooms/new
  def new
    @room = Room.new
    @hotel_id = params[:hotel_id]
  end

  # GET /rooms/1/edit
  def edit; end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to room_url(@room) }
      else
        format.html { redirect_to new_room_path(errors: @room.errors.full_messages) }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to room_url(@room) }
      else
        format.html { redirect_to new_room_path(errors: @room.errors.full_messages) }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    Booking.where(room: @room).delete_all
    @room.destroy

    respond_to do |format|
      format.html { redirect_to hotels_path }
      format.json { head :no_content }
    end
  end

  def book
    room = Room.find(book_params[:room_id])
    if (@current_user.money - room.cost_per_night).positive?
      book_room(room)
    else
      redirect_to room_path(room, errors: [t(:not_enough_money).to_s])
    end
  end

  def unbook
    booking_id = book_params[:booking_id]
    booking = Booking.find(booking_id)
    @current_user.update(money: (@current_user.money + booking.room.cost_per_night))
    @current_user.save
    booking.destroy
    redirect_to user_path(@current_user)
  end

  private

  def book_room(room)
    user_booking = Booking.new(room:, user: @current_user, date: book_params[:date])
    if user_booking.valid?
      user_booking.save
      @current_user.update(money: (@current_user.money - room.cost_per_night))
      @current_user.save
      redirect_to user_path(@current_user)
    else
      redirect_to room_path(room, errors: user_booking.errors.full_messages)
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:hotel, :description, :name, :cost, :hotel_id, :cost_per_night, images: [])
  end

  def book_params
    params.permit(:room_id, :date, :booking_id)
  end
end
