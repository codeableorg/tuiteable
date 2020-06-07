# frozen_string_literal: true

require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_user_test = {
  username: 'admin3',
  name: 'Admin3',
  location: 'Lima',
  email: 'admin3@mail.com',
  bio: 'This is a test of Tuiteabgle user',
  password: 'admin3',
  password_confirmation: 'admin3'
}
puts 'Creating a Admin user...'
User.create!(admin_user_test)
puts 'Admin user was created !!'
puts 'Creating fakes users...'
8.times do
  username = Faker::Internet.username
  email = Faker::Internet.email(name: username)
  name = Faker::Name.name
  location = Faker::Address.city
  bio = Faker::Lorem.paragraphs(number: 1).to_s
  begin
    new_user = User.create!(username: username, email: email, name: name, password: '123456',
                            location: location, bio: bio,
                            password_confirmation: '123456')
  rescue StandardError => e
  end
end
puts 'Fakes users was created !!'
puts 'Creating fakes tuits...'
40.times do
  tuit = {}
  tuit[:body] = Faker::Lorem.paragraph
  tuit[:user] = User.all.sample
  tuit[:created_at] = rand(1..6).days.ago
  begin
    tuit_test = Tuit.create!(tuit)
  rescue StandardError
    puts "ERROR, tuit #{tuit_test}was not created"
  end
end
puts 'Fakes tuits was created...'
puts 'Creating Fakes likes '
60.times do
  user = User.all.sample
  tuit = Tuit.all.sample
  begin
    Like.create!(user: user, tuit: tuit)
  rescue StandardError => e
    puts "ERROR, like not created, because #{e}"
  end
end
puts 'Fakes likes was created...'
puts 'Creating Fakes comments'
# 80.times do
#   body = Faker::Lorem.paragraph
#   user = User.all.sample
#   tuit = Tuit.all.sample
#   Comment.create!(user: user, tuit: tuit, body: body)
# end
puts 'Fakes comments was created...'
User.all.each do |user|
  user.avatar.attach(io: File.open(Dir.pwd + '/public/avatars/diego.png'),
                     filename: 'diego.png', content_type: 'image/png')
end
#  Dir.foreach(Dir.pwd + '/public/avatars/') do |image|
#   next if image == '.' || image == '..'

#   tmp_hash = {}
#   tmp_hash[:io] = File.open(Dir.pwd + '/public/avatars/' + image)
#   tmp_hash[:filename] = image.to_s
#   tmp_hash[:content_type] = 'image/png'
#   images << tmp_hash
# end
# User.all[0..7].each do |user|
#   user.avatar.attach(images.sample)
# end
