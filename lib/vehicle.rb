require 'date'

class Vehicle
  attr_reader :vin,
              :year,
              :make,
              :model,
              :engine,
              :registration_date,
              :plate_type

  def initialize(vehicle_details)
    @vin = vehicle_details[:vin]
    @year = vehicle_details[:year]
    @make = vehicle_details[:make]
    @model = vehicle_details[:model]
    @engine = vehicle_details[:engine]
    @registration_date = nil
    @plate_type = nil
  end
  
  def antique?
    Date.today.year - @year > 25
  end
  
  def electric_vehicle?
    @engine == :ev
  end
  
  def register
    @registration_date = Date.today
    update_plate
  end

  def update_plate
    if engine == :ev
      @plate_type = :ev
    elsif Date.new(year + 25) > Date.today
      @plate_type = :regular
    else
      @plate_type = :antique
    end
  end

  def rate
    if plate_type == :ev
      200
    elsif plate_type == :regular
      100
    else plate_type == :antique
      25
    end
  end
end
