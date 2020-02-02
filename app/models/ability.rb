class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :edit, :destroy, :read, to: :limited_manage

    user ||= User.new
    if user.is? :admin
      can :manage, :all
    end
    can :comment, Post
    can :limited_manage, user
    
    if user.is?(:vip) || user.is?(:premium)
      can :assign_prefix, user
    end
  end
end
