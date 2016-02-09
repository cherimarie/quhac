class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, [Provider, Insurer, ProviderInsurer]

    if user.role == "superadmin"
      can :access, :rails_admin
      can :dashboard
      can :manage, :all
    elsif user.role == "admin"
      can :access, :rails_admin
      can :dashboard
      can :manage, [Provider, Insurer, ProviderInsurer]
    end
  end
end
