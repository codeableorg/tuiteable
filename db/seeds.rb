# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'bcrypt'
require 'faker'
require 'open-uri'

def image_fetcher
  URI.open(Faker::Avatar.image(size: "100x100", format: "jpg", set: "set#{rand(1..4)}"))
  rescue
  URI.open("https://robohash.org/sitsequiquia.jpg?size=100x100&set=set1")
end

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

admins.map do |admin| 
  admin_record = User.create(admin)
  admin_record.avatar.attach({
      io: image_fetcher,
      filename: "#{admin_record.id}_faker_image.jpg"
  })
end

p "Seed regular user"

20.times do |i|
  password = "123456"
  user = User.create(name: Faker::Name.unique.name, username: Faker::Internet.unique.username, email: Faker::Internet.email, bio: Faker::Lorem.sentence, location: Faker::Address.city, password: "123456")
  user.avatar.attach({
      io: image_fetcher,
      filename: "#{user.id}_faker_image.jpg"
  })
end

users = User.all
p "Seed tweets"
130.times do |i|
  Tweet.create(owner: users.sample(), body: Faker::Lorem.sentence)
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
