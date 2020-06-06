# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'bcrypt'
require 'faker'

p "Seed admins"

admins = [
  {
    "username" => "acastemoreno",
    "name" => "Albert",
    "email" => "acastemoreno@gmail.com",
    "password" => "123456",
    "encrypted_password" => BCrypt::Password.create("123456"),
    "bio" => Faker::Lorem.sentence,
    "location" => Faker::Address.city,
    "admin" => true
  },
  {
    "username" => "MariellaUgarte",
    "name" => "Mariella",
    "email" => "juanjoseuagrtellamocca@gmail.com",
    "password" => "123456",
    "encrypted_password" => BCrypt::Password.create("123456"),
    "bio" => Faker::Lorem.sentence,
    "location" => Faker::Address.city,
    "admin" => true
  },
  {
    "username" => "Saidab1",
    "name" => "Saida",
    "email" => "saidabrito57@gmail.com",
    "password" => "123456",
    "encrypted_password" => BCrypt::Password.create("123456"),
    "bio" => Faker::Lorem.sentence,
    "location" => Faker::Address.city,
    "admin" => true
  }
]

admins.map{|admin| User.create(admin)}

p "Seed regular user"

users = []
20.times do |i|
  password = "123456"
  users << { name: Faker::Name.unique.name, username: Faker::Internet.unique.username, email: Faker::Internet.email, encrypted_password: BCrypt::Password.create(password), bio: Faker::Lorem.sentence, location: Faker::Address.city,created_at: Faker::Time.between(from: 3.days.ago, to: Time.now), updated_at: Time.now }
end
User.insert_all!(users)

p "Seed tweets"
User.all.each do |user|
  rand(5..20).times  do |i|
    Tweet.create(owner: user, body: Faker::Lorem.sentence)
  end
end

p "Seed comments"
Tweet.all do |tweet|
  rand(1..13).times  do |i|
    Comment.create(tweet: tweet, user_id: rand(1..23), body: Faker::Lorem.sentence)
  end
end

p "Seed likes"

tweets = Tweet.all

User.all.map do |user|
  tweets.sample(rand(4..30)).each do |tweet|
    Like.create(user: user, tweet: tweet)
  end
end
