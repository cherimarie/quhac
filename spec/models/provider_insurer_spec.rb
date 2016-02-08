require 'rails_helper'

RSpec.describe ProviderInsurer, type: :model do
  before do
    @ins = Insurer.create(name: "Blue Cross")
    @pro = Provider.create(name: "Dr. Feelgood", city: "Funkytown")
    @prov_ins = ProviderInsurer.create(provider_id: @pro.id, insurer_id: @ins.id)
  end

  describe "validations" do
    it "requires a provider & insurer id" do
      expect(ProviderInsurer.new(provider_id: @pro.id)).to be_invalid
      expect(ProviderInsurer.new(insurer_id: @ins.id)).to be_invalid
      expect(ProviderInsurer.new(provider_id: @pro.id, insurer_id: @ins.id)).to be_valid
    end
  end

  describe "associations" do
    it "belongs to insurer" do
      expect(@prov_ins.insurer).to eq(@ins)
    end

     it "belongs to provider" do
      expect(@prov_ins.provider).to eq(@pro)
    end
  end
end
