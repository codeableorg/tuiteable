class TweetPolicy < ApplicationPolicy
  attr_reader :user, :tweet

  def initialize(user, tweet)
    @user = user
    @tweet = tweet
  end

  def update?
    user.admin? || tweet.owner == user
  end

  def destroy?
    user.admin? || tweet.owner == user
  end

  def create?
    user.admin? || tweet.owner == user
  end
end