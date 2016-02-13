require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "submit contact" do
    it "triggers an email" do
      expect { post :submit_contact, comments: "This is super!", robots_are_dumb: "" }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "does not trigger email if robot honeypot hidden field is completed" do
      expect { post :submit_contact, comments: "This is super!", robots_are_dumb: "lulz" }.to_not change { ActionMailer::Base.deliveries.count }
    end
  end
end