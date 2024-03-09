class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:show, :edit, :destroy]
  
  def index
    @reservations = if current_user.admin?
      Reservation.all
    else
      current_user.reservations.where
    end
    @reservations = Reservation.where('reservation_date >= ?', Date.today).order(:reservation_date)
  end

  def new
    @bus = Bus.find(params[:bus_id])
    @reservation = @bus.reservations.new

    @reservations = current_user.reservations
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

