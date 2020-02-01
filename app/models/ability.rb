class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.is? :admin
      can :manage, :all 
      can :assign, :roles
    end
    can :comment, Post
    can :manage, user
    can :edit, user
  end
end
