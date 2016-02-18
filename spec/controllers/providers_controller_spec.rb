require 'rails_helper'

RSpec.describe ProvidersController, type: :controller do
  before do
    @pro1 = Provider.create(name: "Dr. McCoy", city: "Woodinville")
    @pro2 = Provider.create(name: "Dr. Torres", city: "Seattle")
  end
  let!(:monkey_provider) { Provider.create(name: "Dr. Monkey", city: "Bellingham")}
  let!(:lion_provider) { Provider.create(name: "Dr. Lion", city: "Seattle")}


  describe "index" do
    it "returns all providers" do
      get :index

      expect(assigns(:providers).length).to eq(4)
      expect(assigns(:providers)).to include(@pro1)
      expect(assigns(:providers)).to include(@pro2)
      expect(assigns(:providers)).to include(lion_provider)
      expect(assigns(:providers)).to include(monkey_provider)
    end


    it "returns providers that match query" do
      get :index, search: "monkey"

      expect(assigns(:providers)).to eq([monkey_provider])
    end

    it "returns providers that match query" do
      get :index, search: "Seattle"

      expect(assigns(:providers)).to include(lion_provider)
      expect(assigns(:providers)).to include(@pro2)
    end
  end

  describe "show" do
    it "sets the provider correctly" do
      get :show, id: @pro1.id

      expect(assigns(:provider)).to eq(@pro1)
    end
  end

  describe "access" do
    before do
      @admin = User.create(email: "admin1@example.com", password: "password", password_confirmation: "password", role: "admin")
      @superadmin = User.create(email: "superadmin1@example.com", password: "password", password_confirmation: "password", role: "superadmin")
      @user = User.create(email: "user1@example.com", password: "password", password_confirmation: "password", role: "user")
    end

    it "permits users to read Providers" do
      sign_in @user
      get :index

      expect(response.code).to eq('200')
    end

    it "does not allow users to manage Providers" do
      sign_in @user
      put :update, id: @pro1.id, name: "Dr. Ewok"

      expect(response.code).to eq('302')
    end

    it "permits admins to manage Providers" do
      sign_in @admin

      put :update, id: @pro1.id, name: "Dr. Ewok"

      expect(response.code).to eq('200')
    end

    it "permits superadmins to manage Providers" do
      sign_in @superadmin

      put :update, id: @pro1.id, name: "Dr. Ewok"

      expect(response.code).to eq('200')
    end
  end
end
