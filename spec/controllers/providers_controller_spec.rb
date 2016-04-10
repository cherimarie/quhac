require 'rails_helper'

RSpec.describe ProvidersController, type: :controller do
  before do
    clinic1 = Clinic.create(
      name: "Jungle Clinic",
      street_address: "123 Pine St",
      city: "Seattle",
      zip: "98122",
      phone: "206-206-1206"
    )
    @clinic2 = Clinic.create(
      name: "Savannah Clinic",
      street_address: "123 Spruce St",
      city: "Woodinville",
      zip: "98199",
      phone: "206-206-1206"
    )

    @pro2 = Provider.create(
      name: "Dr. Torres",
      clinic_id: clinic1.id,
      specialization: "diabetics, squids",
      type: "phrenologist"
    )
    @monkey_provider = Provider.create(
      name: "Dr. Monkey",
      clinic_id: clinic1.id,
      specialization: "trans-men, athletes",
      type: "dermatologist"
    )

    @pro1 = Provider.create(
      name: "Dr. McCoy",
      clinic_id: @clinic2.id,
      specialization: "trans-men, diabetics, athletes",
      type: ""
    )
    @lion_provider = Provider.create(
      name: "Dr. Lion",
      clinic_id: @clinic2.id,
      specialization: "",
      type: "acupuncturist"
    )
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
  end

  describe "quick search on index" do
    it "returns providers whose name matches query" do
      get :index, search: "monkey"

      expect(assigns(:providers)).to eq([@monkey_provider])
    end

    it "returns providers whose type matches query" do
      get :index, search: "phrenologist"

      expect(assigns(:providers)).to eq([@pro2])
    end

    it "returns providers whose specialization matches query" do
      get :index, search: "trans-men"

      expect(assigns(:providers).length).to eq(2)
      expect(assigns(:providers)).to include(@monkey_provider)
      expect(assigns(:providers)).to include(@pro1)
    end

    it "returns providers whose clinic name matches query" do
      get :index, search: "Savannah"

      expect(assigns(:providers).length).to eq(2)
      expect(assigns(:clinics)).to eq([@clinic2])
      expect(assigns(:providers)).to include(@lion_provider)
      expect(assigns(:providers)).to include(@pro1)
    end
  end

  describe "text search on index" do

  end

  describe "filter search on index" do

  end

  describe "show" do
    it "sets the provider correctly" do
      get :show, id: @pro1.id

      expect(assigns(:provider)).to eq(@pro1)
    end
  end
end
