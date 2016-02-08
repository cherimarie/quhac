require 'rails_helper'

RSpec.describe ProvidersController, type: :controller do
  before do
    @pro1 = Provider.create(name: "Dr. McCoy", city: "Woodinville")
    @pro2 = Provider.create(name: "Dr. Torres", city: "Seattle")
  end

  describe "index" do
    it "returns all providers" do
      get :index

      expect(assigns(:providers).length).to eq(2)
      expect(assigns(:providers)).to include(@pro1)
      expect(assigns(:providers)).to include(@pro2)
    end
  end
end
