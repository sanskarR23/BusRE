class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bus, only: [:index, :destroy, :reservations_for_date]
  before_action :set_reservation, only: [:destroy]

  def index
     @reservations = current_user.reservations   
  end

  def create
    @bus = Bus.find(params[:bus_id])
    @date = params[:reservation][:reservation_date]
    @reservations = @bus.reservations.where(reservation_date: @reservation_date)
    #  column should be renamed - seats -> number_of_seats
    # @available_seats = @bus.seats - @reservations.sum(:seats)
    @available_seats = 45

    # Create a new reservation
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.bus = @bus
    
    if @reservation.save
      flash[:success] = "Seats booked successfully!"
      redirect_to bus_path(@bus, date: @date)
    else
      render :show
    end
  end

  # def create
  #   binding.pry
  #   @bus = Bus.find(params[:bus_id])
    
  #   # Extracting seats and reservation_date from params
  #   seats = params[:reservation][:seats].to_i
  #   reservation_date = params[:reservation][:reservation_date]

  #   # Create reservation
  #   #  reservation_date = Date.strptime(params[:reservation][:reservation_date], '%d-%m-%Y')

  #   @reservation = Reservation.new(seats: seats, reservation_date: reservation_date, bus: @bus)


    
  #   if @reservation.save
  #     # Successfully created reservation
  #     redirect_to @bus, notice: 'Seats booked successfully.'
  #   else
  #     # Handle validation errors or other issues
  #     render 'new'
  #   end
  # end

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
    params.require(:reservation).permit(:seats, :reservation_date)
  end

  def set_reservation
    @reservation = current_user.reservations.find_by(id: params[:id])
  end
end

