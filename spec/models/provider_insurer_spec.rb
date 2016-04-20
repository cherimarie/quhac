require 'rails_helper'

RSpec.describe ProviderInsurer, type: :model do
  before do
    clinic = Clinic.create(street_address: "123 Pine St", city: "Seattle", zip: "98122", phone: "206-206-1206")
    @ins = Insurer.create(name: "Blue Cross")
    @pro = Provider.create(name: "Dr. Feelgood", clinic_id: clinic.id)
    @prov_ins = ProviderInsurer.create(provider_id: @pro.id, insurer_id: @ins.id)
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
