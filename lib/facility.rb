class Facility
  attr_reader :name, 
              :address, 
              :phone, 
              :services,
              :registered_vehicles

  def initialize(data)
    @name = data[:name]
    @address = data[:address]
    @phone = data[:phone]
    @services = []
    @registered_vehicles = []
  end

  def add_service(service)
    @services << service
  end

  # TODO: service checker helper method or module that creates
  # reg vehicles attribute?
end
