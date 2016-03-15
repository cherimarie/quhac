class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, [Provider, Insurer, ProviderInsurer, Clinic]

    if user.role == "superadmin"
      can :access, :rails_admin
      can :dashboard
      can :manage, [Provider, Insurer, Clinic]
      can [:read, :update], [User]
    elsif user.role == "admin"
      can :access, :rails_admin
      can :dashboard
      can :manage, [Provider, Insurer, Clinic]
    end
  end
end
