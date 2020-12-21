class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def update?
    user.admin? || comment.user == user
  end

  def destroy?
    user.admin? || comment.user == user
  end

  def create?
    true
  end
end