require 'rails_helper'

RSpec.describe Insurer, type: :model do
  describe "validations" do
    it "requires a name" do
      expect(Insurer.new()).to be_invalid
      expect(Insurer.new(name: "Primera")).to be_valid
    end
  end

  describe "associations" do
    before do
      @ins = Insurer.create(name: "Blue Cross")
      @pro = Provider.create(name: "Dr. Feelgood", city: "Funkytown")
      @prov_ins = ProviderInsurer.create(provider_id: @pro.id, insurer_id: @ins.id)
    end
    it "has many provider_insurers" do
      expect(@ins.provider_insurers).to eq([@prov_ins])
    end

    it "has many providers" do
      expect(@ins.providers).to eq([@pro])
    end
  end
end
