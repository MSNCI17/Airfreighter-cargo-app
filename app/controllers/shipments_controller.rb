class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]

  # GET /shipments
  # GET /shipments.json
  def index
    @shipments = current_user.shipments
  end

  # GET /shipments/1
  # GET /shipments/1.json
  def show
  end

  # GET /shipments/new
  def new
    if params.present?
      if params[:flight_ident].present?
        @flight_ident = params[:flight_ident]
      end
      if params[:departure_time].present?
        @flight_departure_time = Time.at(params[:departure_time].to_i)
      end
    end
    @shipment = Shipment.new
  end

  # GET /shipments/1/edit
  def edit
  end

  # POST /shipments
  # POST /shipments.json
  def create
    @shipment = Shipment.new(shipment_params)

    respond_to do |format|
      if @shipment.save
        format.html { redirect_to shipments_path, notice: 'Shipment was successfully created.' }
        format.json { render :show, status: :created, location: @shipment }
      else
        format.html { render :new }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipments/1
  # PATCH/PUT /shipments/1.json
  def update
    respond_to do |format|
      if @shipment.update(shipment_params)
        format.html { redirect_to shipments_path, notice: 'Shipment was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipment }
      else
        format.html { render :edit }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  def track
    test = FlightXML2REST.new(Rails.application.secrets.flightaware_api_user, Rails.application.secrets.flightaware_api_key)
    departure = params[:departure].to_i
    ident = params[:ident]
    @shipment = Shipment.find(params[:id])

    @flight_id = test.GetFlightID(GetFlightIDRequest.new(departure, ident))
    if @flight_id.getFlightIDResult.present?
      @flight_info = test.FlightInfoEx(FlightInfoExRequest.new(1, @flight_id.getFlightIDResult,0))
    end
  end

  # DELETE /shipments/1
  # DELETE /shipments/1.json
  def destroy
    @shipment.destroy
    respond_to do |format|
      format.html { redirect_to shipments_url, notice: 'Shipment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipment
      @shipment = Shipment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipment_params
      params.require(:shipment).permit(:ident, :tracking_code, :weight, :length, :height, :width, :product, :etd, :eta,
                                       :service_level, :quotation, :status, :cbm, :origin, :destination, :no_of_products,
                                       :user_id)
    end
end
