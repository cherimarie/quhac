require 'rails_helper'

RSpec.describe Provider, type: :model do
  describe "validations" do
    it "requires a name and clinic_id" do
      clinic = Clinic.create(street_address: "123 Pine St", city: "Seattle", zip: "98122", phone: "206-206-1206")
      expect(Provider.new(name: "Dr. Feelgood", clinic_id: nil)).to be_invalid
      expect(Provider.new(name: nil, clinic_id: clinic.id)).to be_invalid
      expect(Provider.new(name: "Dr. Feelgood", clinic_id: clinic.id)).to be_valid
    end
  end

  describe "associations" do
    before do
      @clinic = Clinic.create(street_address: "123 Pine St", city: "Seattle", zip: "98122", phone: "206-206-1206")
      @ins = Insurer.create(name: "Blue Cross")
      @pro = Provider.create(name: "Dr. Feelgood", clinic_id: @clinic.id)
      @prov_ins = ProviderInsurer.create(provider_id: @pro.id, insurer_id: @ins.id)
    end
    it "has many provider_insurers" do
      expect(@pro.provider_insurers).to eq([@prov_ins])
    end

    it "has many insurers" do
      expect(@pro.insurers).to eq([@ins])
    end

    it "belongs to a clinic" do
      expect(@pro.clinic).to eq(@clinic)
    end
  end

  describe "delegations" do
    before do
      @clinic = Clinic.create(street_address: "123 Pine St", city: "Seattle", zip: "98122", phone: "206-206-1206")
      @pro = Provider.create(name: "Dr. Feelgood", clinic_id: @clinic.id)
    end

    it "delegates street_address to clinic" do
      expect(@pro.street_address).to eq(@clinic.street_address)
    end

    it "delegates city to clinic" do
      expect(@pro.city).to eq(@clinic.city)
    end

    it "delegates zip to clinic" do
      expect(@pro.zip).to eq(@clinic.zip)
    end

    it "delegates phone to clinic" do
      expect(@pro.phone).to eq(@clinic.phone)
    end

    it "delegates website to clinic" do
      expect(@pro.website).to eq(@clinic.website)
    end
  end
end
