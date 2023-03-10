class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post

    return unless user.present?

    can :read, Post, author: user
    can :create, Post, author_id: user.id
    can :create, Post if user.persisted?
    can :create, Comment if user.persisted?

    if user.role == 'admin'
      can :manage, :all
    else
      can [:update, :destroy], Post, author_id: user.id
      can [:create, :destroy], Comment, post: { author_id: user.id }
    end
  end
end
