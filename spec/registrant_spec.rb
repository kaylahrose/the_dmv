require 'spec_helper'

RSpec.describe Registrant do
  let!(:registrant_1) {Registrant.new("Jenny", 12)}
  let!(:registrant_2) {Registrant.new("Joey", 2, true)}

  it '#initialize' do
    expect(registrant_1.name).to eq("Jenny")
    expect(registrant_1.age).to eq(12)
    expect(registrant_1.permit?).to eq(false)
    expect(registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    
    expect(registrant_2.name).to eq("Joey")
    expect(registrant_2.age).to eq(2)
    expect(registrant_2.permit?).to eq(true)
    expect(registrant_2.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
  end

  describe 'instance methods' do
    it '#ear_permit' do
      expect(registrant_1.permit).to eq(false)
      
      registrant_1.earn_permit
      
      expect(registrant_1.permit).to eq(true)
    end

    it '#permit?' do
      expect(registrant_1.permit?).to eq(false)
      expect(registrant_2.permit?).to eq(true)
    end
  end
end