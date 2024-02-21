class BusesController < ApplicationController
  before_action :set_bus, only: [:show, :edit, :update, :destroy] 
  before_action :calculate_available_seats, only: [:index]

  # GET /buses or /buses.json
  def index
    @buses = Bus.all
    @buses = @buses.search(params[:search]) if params[:search].present?
  end

  # GET /buses/1 or /buses/1.json
  def show
    @bus = Bus.find(params[:id])   

    # Retrieve reservations for the given bus on the specified date
    @reservations = @bus.reservations.where(reservation_date: @date)
     # Calculate available seats
    @available_seats = @bus.seats - @reservations.sum(:seats)

    # Initialize a new reservation for the booking form
    @reservation = Reservation.new
  end

  def create_reservation
    binding.pry
    @bus = Bus.find(params[:id])
    @date = params[:date]
    @reservations = @bus.reservations.where(reservation_date: @date)
    @available_seats = @bus.seats - @reservations.sum(:seats)

    # Create a new reservation
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.bus = @bus
    @reservation.reservation_date = @date

    
    if @reservation.save
      flash[:success] = "Seats booked successfully!"
      redirect_to bus_path(@bus, date: @date)
    else
      render :show
    end
  end

  # GET /buses/new
  def new
    @bus = Bus.new
  end

  # GET /buses/1/edit
  def edit
  end

  # POST /buses or /buses.json
  def create
    @bus = Bus.new(bus_params)

    respond_to do |format|
      if @bus.save
        format.html { redirect_to bus_url(@bus), notice: "Bus was successfully created." }
        format.json { render :show, status: :created, location: @bus }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buses/1 or /buses/1.json
  def update
    respond_to do |format|
      if @bus.update(bus_params)
        format.html { redirect_to bus_url(@bus), notice: "Bus was successfully updated." }
        format.json { render :show, status: :ok, location: @bus }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buses/1 or /buses/1.json
  def destroy
    @bus.destroy!

    respond_to do |format|
      format.html { redirect_to buses_url, notice: "Bus was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bus
      @bus = Bus.find(params[:id])
    end

  def reservation_params
    params.require(:reservation).permit(:seats, :user_id, :reservation_date)
  end

  def calculate_available_seats
    @available_seats = {}
    Bus.all.each do |bus|
      total_seats = bus.seats
      reserved_seats = bus.reservations.sum(:seats)
      available_seats = total_seats - reserved_seats
      @available_seats[bus.id] = available_seats
    end
  end
   # Only allow a list of trusted parameters through.
    def bus_params
      params.require(:bus).permit(:name, :registration_no, :route, :seats, :user_id)
    end
end