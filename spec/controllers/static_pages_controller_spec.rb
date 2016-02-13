require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "submit contact" do
    it "triggers an email" do
      expect { post :submit_contact, comments: "This is super!" }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end