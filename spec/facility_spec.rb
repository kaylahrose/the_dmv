require 'spec_helper'

RSpec.describe Facility do
  let!(:facility) {Facility.new({name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })}

  describe '#initialize' do
    it 'can initialize' do
      expect(facility).to be_an_instance_of(Facility)
      expect(facility.name).to eq('Albany DMV Office')
      expect(facility.address).to eq('2242 Santiam Hwy SE Albany OR 97321')
      expect(facility.phone).to eq('541-967-2014')
      expect(facility.services).to eq([])
      expect(facility.registered_vehicles).to eq([])
      expect(facility.collected_fees).to eq(0)
    end
  end

  describe 'instance methods' do
    it '#add_service' do
      expect(facility.services).to eq([])
      facility.add_service('New Drivers License')
      facility.add_service('Renew Drivers License')
      facility.add_service('Vehicle Registration')
      expect(facility.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end

    describe '#register_vehicles' do
      let!(:facility_1) {Facility.new({name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })}
      let!(:facility_2) { Facility.new({name: 'Ashland DMV Office', address: '600 Tolman Creek Rd Ashland OR 97520', phone: '541-776-6092' })}
      let!(:cruz) { Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )}
      let!(:bolt) { Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )}
      let!(:camaro) { Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )}

      before(:each) do
        facility_1.add_service('Vehicle Registration')
      end

      it '#register_vehicle creates a cars registration date, plate type, and collects facility fees' do
        expect(cruz.registration_date).to eq(nil)
        expect(facility_1.registered_vehicles).to eq([])
        expect(facility_1.collected_fees).to eq(0)

        facility_1.register_vehicle(cruz)

        expect(cruz.registration_date).to be_a Date
        expect(cruz.plate_type).to eq(:regular)
        expect(facility_1.registered_vehicles).to be_a Array
        expect(facility_1.registered_vehicles[0]).to eq(cruz)
        expect(facility_1.collected_fees).to eq(100)
        
        facility_1.register_vehicle(camaro)
        
        expect(camaro.registration_date).to be_a Date
        expect(camaro.plate_type).to eq(:antique)
        expect(facility_1.collected_fees).to eq(325)
        expect(facility_2.registered_vehicles).to eq([])
        expect(facility_2.services).to eq([])
        
        facility_2.register_vehicle(camaro)

        expect(facility_2.registered_vehicles).to eq(nil)
        expect(facility_2.collected_fees).to eq(0)
      end
    end
  end
end
