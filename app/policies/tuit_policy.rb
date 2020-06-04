class TuitPolicy < ApplicationPolicy
  attr_reader :user, :tuit

  def initialize(user)
    @user = user
    @tuit = tuit
  end

  def update?
    user.is_admin?
  end

  def destroy?
    user.is_admin?
  end

  def create?
    user.is_admin?
  end
end