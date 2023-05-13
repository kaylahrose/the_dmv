class Facility
  attr_reader :name, :address, :phone, :services

  def initialize(data)
    @name = data[:name]
    @address = data[:address]
    @phone = data[:phone]
    @services = []
  end

  def add_service(service)
    @services << service
  end
end
