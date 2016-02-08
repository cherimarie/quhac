require 'rails_helper'

RSpec.describe Provider, type: :model do
  describe "validations" do
    it "requires a name and city" do
      expect(Provider.new(name: "Dr. Feelgood")).to be_invalid
      expect(Provider.new(city: "Funkytown")).to be_invalid
      expect(Provider.new(name: "Dr. Feelgood", city: "Funkytown")).to be_valid
    end
  end

  describe "associations" do
    before do
      @ins = Insurer.create(name: "Blue Cross")
      @pro = Provider.create(name: "Dr. Feelgood", city: "Funkytown")
      @prov_ins = ProviderInsurer.create(provider_id: @pro.id, insurer_id: @ins.id)
    end
    it "has many provider_insurers" do
      expect(@pro.provider_insurers).to eq([@prov_ins])
    end

    it "has many insurers" do
      expect(@pro.insurers).to eq([@ins])
    end
  end
end
