class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:show, :edit, :destroy]
  
  def index
    owners = User.where(role: :owner)
    users = User.where(role: :user)

    @reservations = current_user.reservations   
    @reservation_date = Date.today 
  end

  def new
    @bus = Bus.find(params[:bus_id])
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    seats_string = params[:reservation][:seats].first
    seats = seats_string.split(',').map(&:to_i)
    @reservation.seats = seats

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to reservations_path, notice: "Reservation was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @reservation
      @reservation.destroy
      redirect_to reservations_path, notice: "Reservation canceled successfully!"
    else
      redirect_to reservations_path, alert: "Reservation not found."
    end
    
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def set_bus
    @bus = Bus.find_by(id: params[:bus_id])    
  end

  def reservation_params
    params.require(:reservation).permit(:seats, :reservation_date, :user_id, :bus_id, :number_of_seats)
  end

  def set_reservation
    @reservation = current_user.reservations.find_by(id: params[:id])
  end
end

