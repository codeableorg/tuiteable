class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def update?
    user.is_admin? || comment.user == user
  end

  def destroy?
    user.is_admin? || comment.user == user
  end
end
