require 'rails_helper'

RSpec.describe ProvidersController, type: :controller do
  before do
    clinic1 = Clinic.create(street_address: "123 Pine St", city: "Seattle", zip: "98122", phone: "206-206-1206")
    clinic2 = Clinic.create(street_address: "123 Spruce St", city: "Woodinville", zip: "98199", phone: "206-206-1206")
    @pro1 = Provider.create(name: "Dr. McCoy", clinic_id: clinic2.id)
    @pro2 = Provider.create(name: "Dr. Torres", clinic_id: clinic1.id)
    @monkey_provider = Provider.create(name: "Dr. Monkey", clinic_id: clinic1.id)
    @lion_provider = Provider.create(name: "Dr. Lion", clinic_id: clinic2.id)
  end


  describe "index" do
    it "returns all providers" do
      get :index

      expect(assigns(:providers).length).to eq(4)
      expect(assigns(:providers)).to include(@pro1)
      expect(assigns(:providers)).to include(@pro2)
      expect(assigns(:providers)).to include(@lion_provider)
      expect(assigns(:providers)).to include(@monkey_provider)
    end


    it "returns providers that match query" do
      get :index, search: "monkey"

      expect(assigns(:providers)).to eq([@monkey_provider])
    end

    it "returns providers that match query" do
      pending "search does not hit city right now, as it's delegated to clinic"
      get :index, search: "Seattle"

      expect(assigns(:providers)).to include(@lion_provider)
      expect(assigns(:providers)).to include(@pro2)
    end
  end

  describe "show" do
    it "sets the provider correctly" do
      get :show, id: @pro1.id

      expect(assigns(:provider)).to eq(@pro1)
    end
  end
end
