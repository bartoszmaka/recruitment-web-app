class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, User
      cannot :destroy, User, id: user.id
    elsif user.persisted?
      can :read, User
    end
  end
end
