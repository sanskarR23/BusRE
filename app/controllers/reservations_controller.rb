class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bus, only: [:index, :destroy, :reservations_for_date]

  def index
     @reservations = current_user.reservations   
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
  def set_reservation
    @reservation = current_user.reservations.find_by(id: params[:id])
  end
end