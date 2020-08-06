require 'faker'

REGISTERED_USERS = 7..20
TUITS_PER_USER = 1..7
COMMENTS_PER_USER = 1..5
TUITS_LIKED_PER_USER = 1..7

# create admin
User.create!(username: 'admin', password: 123456, email: "admin@admin.com", is_admin: true)

# create some users
puts 'Creating users...'
users = Array.new(rand(REGISTERED_USERS)) do
  User.create!({
    username: Faker::Internet.username,
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 123456,
    bio: Faker::Quote.matz,
    location: Faker::Address.country,
  })
end

# create some tuits
puts 'Creating Tuits...'

tuits = users.each_with_object([]) do |user, all_tuits|
  rand(TUITS_PER_USER).times do
    all_tuits << user.tuits.create!({
      body: Faker::Quotes::Chiquito.joke,
    })
  end
end

# create votes
puts 'Adding Votes...'

users.each do |user|
  tuits.sample(rand(TUITS_LIKED_PER_USER)).each do |tuit|
    tuit.votes.create!(user: user)
  end
end

# create some comments
puts 'Creating Comments...'

tuits.each do |tuit|
  rand(COMMENTS_PER_USER).times do
    tuit.comments.create!({
      user: users[rand(users.size)],
      body: Faker::Quotes::Chiquito.sentence,
    })
  end
end
