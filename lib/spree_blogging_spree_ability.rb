class SpreeBloggingSpreeAbility
  include CanCan::Ability

  def initialize(user)
    can :read, BlogEntry
    can :index, BlogEntry
  end
end
