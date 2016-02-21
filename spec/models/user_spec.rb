require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'abilities' do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }

    context 'user' do
      let(:user) { User.create(role: "user", email: "user@example.com", password: "password", password_confirmation: "password")}
      it{ should_not be_able_to(:manage, Provider.new) }
      it{ should_not be_able_to(:manage, Insurer.new) }
      it{ should_not be_able_to(:manage, ProviderInsurer.new) }
      it{ should_not be_able_to(:manage, User.new) }
      it{ should_not be_able_to(:access, :rails_admin) }
    end

    context 'admin' do
      let(:user) { User.create(role: "admin", email: "admin@example.com", password: "password", password_confirmation: "password")}

      it{ should be_able_to(:manage, Provider.new) }
      it{ should be_able_to(:manage, Insurer.new) }
      it{ should_not be_able_to(:manage, ProviderInsurer.new) }
      it{ should_not be_able_to(:manage, User.new) }
      it{ should_not be_able_to(:update, User.new) }
      it{ should be_able_to(:access, :rails_admin) }
    end

    context 'superadmin' do
      let(:user) { User.create(role: "superadmin", email: "superadmin@example.com", password: "password", password_confirmation: "password")}

      it{ should be_able_to(:manage, Provider.new) }
      it{ should be_able_to(:manage, Insurer.new) }
      it{ should_not be_able_to(:manage, ProviderInsurer.new) }
      it{ should_not be_able_to(:manage, User.new) }
      it{ should be_able_to(:update, User.new) }
      it{ should be_able_to(:access, :rails_admin) }
    end

    context 'rando' do
      let(:user) { User.create(role: "donkey", email: "rando@example.com", password: "password", password_confirmation: "password")}
      it{ should_not be_able_to(:manage, Provider.new) }
      it{ should_not be_able_to(:manage, Insurer.new) }
      it{ should_not be_able_to(:manage, ProviderInsurer.new) }
      it{ should_not be_able_to(:manage, User.new) }
      it{ should_not be_able_to(:access, :rails_admin) }
    end
  end

end
