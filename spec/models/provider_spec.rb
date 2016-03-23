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

  describe "methods" do
    before do
      clinic = Clinic.create(street_address: "123 Pine St", city: "Seattle", zip: "98122", phone: "206-206-1206")
      @ins = Insurer.create(name: "Blue Cross")
      @care = Insurer.create(name: "Medicare")
      @caid = Insurer.create(name: "Molina")

      @takes_neither = Provider.create(name: "Dr. Feelgood", clinic_id: clinic.id)
      ProviderInsurer.create(provider_id: @takes_neither.id, insurer_id: @ins.id)

      @takes_care = Provider.create(name: "Dr. Feelgood", clinic_id: clinic.id)
      ProviderInsurer.create(provider_id: @takes_care.id, insurer_id: @care.id)

      @takes_caid = Provider.create(name: "Dr. Feelgood", clinic_id: clinic.id)
      ProviderInsurer.create(provider_id: @takes_caid.id, insurer_id: @caid.id)

      @takes_both = Provider.create(name: "Dr. Feelgood", clinic_id: clinic.id)
      ProviderInsurer.create(provider_id: @takes_both.id, insurer_id: @caid.id)
      ProviderInsurer.create(provider_id: @takes_both.id, insurer_id: @care.id)
    end

    it "returns a yes string if accepts medicare" do
      expect(@takes_both.accepts_medicare).to eq("yes")
      expect(@takes_care.accepts_medicare).to eq("yes")
    end

    it "returns a no string if not accepts medicare" do
      expect(@takes_neither.accepts_medicare).to eq("no")
      expect(@takes_caid.accepts_medicare).to eq("no")
    end

    it "returns a yes string if accepts medicaid" do
      expect(@takes_both.accepts_medicaid).to eq("yes")
      expect(@takes_caid.accepts_medicaid).to eq("yes")
    end

    it "returns a no string if not accepts medicaid" do
      expect(@takes_neither.accepts_medicaid).to eq("no")
      expect(@takes_care.accepts_medicaid).to eq("no")
    end
  end
end
