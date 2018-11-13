class DashboardController < ApplicationController

  before_filter :get_airports
  USERNAME = 'mshevlin'
  APIKEY   = '6ba354482ad2ae3768305315e33e6f67f4ecfc56'



  def index
    @title = 'AirFreighter Homepage'
    if checkParams(params)
      search(params)
    end
  end

  def checkParams(params)
    return true if params[:destination] || params[:origin] || params[:start_date] else false
  end

  def search(params)

    test = FlightXML2REST.new(Rails.application.secrets.flightaware_api_user, Rails.application.secrets.flightaware_api_key)
    start_date = Date.strptime(params[:start_date], '%m/%d/%Y')
    end_date = start_date + 10.days
    start_date = start_date.to_time.to_i
    end_date = end_date.to_time.to_i
    result = test.AirlineFlightSchedules(AirlineFlightSchedulesRequest.new('', params[:destination], end_date, nil, 15, 0, params[:origin], start_date))
    @flights = result.airlineFlightSchedulesResult.data
  end

  def get_airports
    @airports = []
    airports = Airports.all

    airports.each do |airport|
      @airports << {name: "#{airport.name} - #{airport.city} - #{airport.country}", iata: airport.icao}
    end
  end
end
