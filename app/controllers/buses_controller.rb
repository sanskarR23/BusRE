class BusesController < ApplicationController
  before_action :set_bus, only: [:show, :edit, :update, :destroy]
  
  def index
    @buses = Bus.all
    @buses = @buses.search(params[:search]) if params[:search].present?
  end

  def show
    # Retrieve reservations for the given bus on the specified date
    @reservation_list = @bus.reservations.group_by(&:reservation_date)
    @reservation = Reservation.new
    
  end

  def new
    @bus = Bus.new
  end

  def edit
    
  end

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

    # Only allow a list of trusted parameters through.
    def bus_params
      params.require(:bus).permit(:name, :registration_no, :route, :number_of_seats)
    end
end
