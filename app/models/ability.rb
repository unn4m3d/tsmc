class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.is? :admin
      can :manage, :all 
      can :assign, :roles
      can :assign_prefix, User
    end
    can :comment, Post
    can :manage, user
    can :edit, user
    
    if user.is?(:vip) || user.is?(:premium)
      can :assign_prefix, user
    end
  end
end
