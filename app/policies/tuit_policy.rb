class TuitPolicy < ApplicationPolicy
  attr_reader :user, :tuit

  def initialize(user, tuit)
    @user = user
    @tuit = tuit
  end

  def update?
    user.is_admin? || tuit.owner == user
  end

  def destroy?
    user.is_admin? || tuit.owner == user
  end
end
