# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

# admin account
admin = User.create!(
  username: 'admin',
  email: 'admin@mail.com',
  display_name: 'admin',
  admin: true,
  bio: Faker::Quote.most_interesting_man_in_the_world,
  location: Faker::Address.city,
  password: '123456',
)

puts "---------------------------------"
puts "admin account added. credentials:"
puts "username: #{admin.username}"
puts "email: #{admin.email}"
puts "password: #{admin.password}"
puts "---------------------------------"

puts "create users"
users = Array.new(20) do
  User.create!({
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    display_name: Faker::Name.name,
    admin: false,
    bio: Faker::Quote.most_interesting_man_in_the_world,
    location: Faker::Address.city,
    password: '123456',
  })
end

puts 'create tweets'
tweets = users.each_with_object([]) do |user, all_tweets|
  20.times do
    all_tweets << user.tweets.create!({
      body: Faker::Quote.most_interesting_man_in_the_world,
    })
  end
end

puts 'create comments'
tweets.each do |tweet|
  4.times do
    tweet.comments.create!({
      user: users[rand(users.size)],
      body: Faker::Quote.most_interesting_man_in_the_world,
    })
  end
end
