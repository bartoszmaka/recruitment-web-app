class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, User do |target_user|
        target_user.id != user.id
      end
    end
    can :read, User if user.persisted?
  end
end
