# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts 'Creating Users'
20.times do
  User.create!(
    username: Faker::Name.unique.name.split.join(''),
    name: Faker::Name.name,
    email: Faker::Internet.email,
  )
end

users = User.all

puts 'Creating Tuits'

users.each do |user|
  rand(6..10).times do
    user.tuits.create!(
      body: Faker::Lorem.sentence,
    )
  end
end

puts 'Creating Comments'

tuits = Tuit.all
tuits.each do |tuit|
  User.all.sample(rand(3..6)).each do |user|
    tuit.comments.create!(
      body: Faker::Lorem.sentence,
      user: user,
    )
  end
end

puts 'Creating Likes'

tuits_count = tuits.size
tuits.sample(rand(tuits_count)).each do |tuit|
  User.all.sample(rand(1..5)).each do |user|
    tuit.likes.create!(user: user)
  end
end
