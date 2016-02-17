require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  let!(:monkey_provider) { Provider.create(name: "Dr. Monkey", city: "Bellingham")}
  let!(:lion_provider) { Provider.create(name: "Dr. Lion", city: "Seattle")}

  describe "new search" do
    it "returns providers that match query" do
      get :new, search: "monkey"

      expect(assigns(:providers)).to eq([monkey_provider])
    end

    it "returns providers that match query" do
      get :new, search: "Seattle"

      expect(assigns(:providers)).to eq([lion_provider])
    end
  end

end