require 'rails_helper'

RSpec.describe Clinic, type: :model do
  describe "validations" do
    it "requires a street address" do
      expect(Clinic.new(street_address: nil, city: "Seattle", zip: "98122", phone: "206-206-1206")).to be_invalid
    end
    it "requires a city" do
      expect(Clinic.new(street_address: "123 Pine St", city: nil, zip: "98122", phone: "206-206-1206")).to be_invalid
    end
    it "requires a zip" do
      expect(Clinic.new(street_address: "123 Pine St", city: "Seattle", zip: nil, phone: "206-206-1206")).to be_invalid
    end
    it "requires a phone number" do
      expect(Clinic.new(street_address: "123 Pine St", city: "Seattle", zip: "98122", phone: nil)).to be_invalid
    end
  end

  describe "associations" do
    before do
      @clinic = Clinic.create(street_address: "123 Pine St", city: "Seattle", zip: "98122", phone: "206-206-1206")
      @pro = Provider.create(name: "Dr. Feelgood", clinic_id: @clinic.id)
    end
    it "has many providers" do
      expect(@clinic.providers).to eq([@pro])
    end
    it "destroys dependent providers on delete" do
      expect{@clinic.destroy}.to change{Provider.count}.by(-1)
    end
  end
end
