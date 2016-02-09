class Ability
  include CanCan::Ability

  def initialize(user)
     user ||= User.new # guest user (not logged in)
      if user.role == "superadmin"
        can :manage, :all
      elsif user.role == "admin"
         can :manage, Provider
         can :manage, Insurer
         can :manage, ProviderInsurer
      else
        can :read, Provider
        can :read, Insurer
        can :read, ProviderInsurer
      end
  end
end
