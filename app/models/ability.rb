class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, :all if user.is? :admin
    can :comment, Post
    can :manage, self
  end
end
